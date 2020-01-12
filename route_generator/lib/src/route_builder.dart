import 'dart:async';

import 'package:build/build.dart';
import 'package:glob/glob.dart';
import 'package:route_annotation/route_annotation.dart';
import 'package:route_generator/src/real_route_page.dart';
import 'package:source_gen/source_gen.dart';

import 'real_route_paramemter.dart';

const _outputExtensions = '.route.dart';

class RouteBuilder implements Builder {
  @override
  Map<String, List<String>> get buildExtensions => {
        '.dart': [_outputExtensions]
      };

  @override
  Future build(BuildStep buildStep) async {
    final resolver = buildStep.resolver;
    if (!await resolver.isLibrary(buildStep.inputId)) return;
    final lib = await buildStep.inputLibrary;
    final reader = LibraryReader(lib);
    String output;
    if (reader.annotatedWith(TypeChecker.fromRuntime(Router)).isNotEmpty) {
      output = await _generate(reader, buildStep);
      await buildStep.writeAsString(
        buildStep.inputId.changeExtension(_outputExtensions),
        output,
      );
    }
  }

  Future<String> _generate(LibraryReader reader, BuildStep buildStep) async {
    List<RealRoutePage> routes = [];
    final pattern = '*/*.dart';
    final assetIds = await buildStep.findAssets(Glob(pattern)).toList()
      ..sort();
    final resolver = buildStep.resolver;
    for (var inputId in assetIds) {
      if (!await resolver.isLibrary(inputId)) continue;
      final lib = await resolver.libraryFor(inputId);
      final route = await _generateRoutePage(LibraryReader(lib), inputId);
      if (route != null) {
        routes.add(route);
      }
    }
    return '''
$defaultFileHeader

import 'package:flutter/material.dart';
${routes.map((e) => e.import).join('\n')}

${routes.map((e) => e.buildRouteName()).join('\n')}

final RouteFactory onGenerateRoute = (settings) => <String, RouteFactory>{
${routes.map((e) => e.buildRouteEntries()).join('')}
}[settings.name](settings);

''';
  }

  Future<RealRoutePage> _generateRoutePage(
      LibraryReader library, AssetId inputId) async {
    try {
      final annotatedElement =
          library.annotatedWith(TypeChecker.fromRuntime(RoutePage)).first;
      final className = annotatedElement.element.displayName;
      final path = inputId.path;
      final package = inputId.package;
      final import =
          "import 'package:$package/${path.replaceFirst('lib/', '')}';";
      final isInitialRoute =
          annotatedElement.annotation.peek("isInitialRoute").boolValue;
      final peekName = annotatedElement.annotation.peek("name")?.stringValue ??
          "/$className";
      final routeName = isInitialRoute ? "home" : peekName;
      final route = RealRoutePage(
        import,
        className,
        routeName,
        isInitialRoute: isInitialRoute,
        params: _generateParameters(annotatedElement.annotation.peek("params")),
      );
      return route;
    } on StateError catch (_) {
      return null;
    }
  }

  List<RealRouteParameter> _generateParameters(ConstantReader value) {
    return value?.listValue
            ?.map((value) => RealRouteParameter(
                value.getField("name").toStringValue(),
                key: value.getField("key").toStringValue()))
            ?.toList() ??
        <RealRouteParameter>[];
  }
}
