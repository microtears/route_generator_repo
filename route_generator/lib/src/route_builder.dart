import 'dart:async';

import 'package:build/build.dart';
import 'package:glob/glob.dart';
import 'package:route_annotation/route_annotation.dart';
import 'package:route_generator/src/annotation.dart';
import 'package:source_gen/source_gen.dart';

const _outputExtensions = '.app_route.dart';

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
    if (reader.annotatedWith(TypeChecker.fromRuntime(AppRouter)).isNotEmpty) {
      output = await _generate(reader, buildStep);
      await buildStep.writeAsString(
        buildStep.inputId.changeExtension(_outputExtensions),
        output,
      );
    }
  }

  Future<String> _generate(LibraryReader reader, BuildStep buildStep) async {
    final List<ActualRoute> routes = [];
    final pattern = '**/*.dart';
    final assetIds = await buildStep.findAssets(Glob(pattern));
    final resolver = buildStep.resolver;
    await for (var inputId in assetIds) {
      if (!await resolver.isLibrary(inputId)) continue;
      final lib = await resolver.libraryFor(inputId);
      final route = await _generateRoutePage(LibraryReader(lib), inputId);
      if (route != null) {
        routes.add(route);
      }
    }
    routes.sort();
    return '''
$defaultFileHeader

import 'package:flutter/material.dart';
${routes.map((e) => e.import).join('\n')}

${routes.map((e) => e.routeNameStatement).join('\n')}

final RouteFactory onGenerateRoute = (settings) => <String, RouteFactory>{
${routes.map((e) => e.buildRouteEntries()).join('')}
}[settings.name](settings);

''';
  }

  Future<ActualRoute> _generateRoutePage(
      LibraryReader library, AssetId inputId) async {
    try {
      final annotatedElement =
          library.annotatedWith(TypeChecker.fromRuntime(Route)).first;
      final className = annotatedElement.element.displayName;
      final path = inputId.path;
      final package = inputId.package;
      final import =
          "import 'package:$package/${path.replaceFirst('lib/', '')}';";
      final isInitialRoute =
          annotatedElement.annotation.peek("isInitialRoute").boolValue;
      final peekName = annotatedElement.annotation.peek("name")?.stringValue ??
          "/$className";
      final routeName = isInitialRoute&&peekName==null ? "home" : peekName;
      final route = ActualRoute(
        import,
        className,
        routeName,
        isInitialRoute: isInitialRoute,
        params: _generateParams(annotatedElement.annotation.peek("params")),
      );
      return route;
    } on StateError catch (_) {
      return null;
    }
  }

  List<ActualRouteParam> _generateParams(ConstantReader value) {
    return value?.listValue
            ?.map((value) => ActualRouteParam(
                value.getField("name").toStringValue(),
                key: value.getField("key").toStringValue()))
            ?.toList() ??
        <ActualRouteParam>[];
  }
}
