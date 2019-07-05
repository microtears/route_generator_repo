import 'package:build/build.dart';
import 'package:route_annotation/route_annotation.dart';
import 'package:route_generator/src/string_case.dart';
import 'package:source_gen/source_gen.dart';

import 'route_generator.dart';
import 'values.dart';

class RouteCollector extends Generator {
  TypeChecker get pageChecker => TypeChecker.fromRuntime(RoutePage);
  bool hasInitialRoute = false;

  @override
  generate(LibraryReader library, BuildStep buildStep) async {
    final routerValues = RouteGenerator.routerValues;
    final nameValues = RouteGenerator.nameValues;
    for (var annotatedElement in library.annotatedWith(pageChecker)) {
      final className = annotatedElement.element.displayName;
      final routeFieldName = annotatedElement.annotation.peek("routeFieldName").stringValue;
      final path = buildStep.inputId.path;
      final package = buildStep.inputId.package;
      final generatedRoute = annotatedElement.annotation.peek("generatedRoute").boolValue;
      final import = path.contains('lib/') ? "package:$package/${path.replaceFirst('lib/', '')}" : path;
      routerValues.addImport(import);
      if (generatedRoute) {
        final pageValues = Values();
        final isInitialRoute = annotatedElement.annotation.peek("isInitialRoute").boolValue;
        final isAlias = annotatedElement.annotation.peek("isAlias").boolValue;
        final peekName = annotatedElement.annotation.peek("name")?.stringValue ?? "/$className";
        final name = isInitialRoute ? "/" : peekName;
        final prarms = mapPrarms(annotatedElement.annotation.peek("prarms"));
        final routeVariableName = _normalizeName(name, false);
        final routeConstantName = _formatLC2UU(routeVariableName);
        final routeName = _formatLC2LU(routeVariableName);

        if (isInitialRoute) {
          if (hasInitialRoute == true) {
            throw UnsupportedError("There can only be one initialization page,$name's isInitialRoute should be false");
          }
          hasInitialRoute = true;
        }
        routerValues.addLine(buildLine(className, generatedRoute, null, routeVariableName));
        routerValues.addImport(import);
        pageValues.addRoute(buildRoute(routeVariableName, routeName, className, buildRouteParam(prarms)));
        if (isInitialRoute) {
          nameValues.addLine(buildRouteName(_formatLC2UU(_normalizeName(peekName, false)), name, false));
        }
        routerValues.addValues(pageValues);
        nameValues.addLine(buildRouteName(routeConstantName, routeName, isAlias));
      } else {
        routerValues.addLine(buildLine(className, generatedRoute, routeFieldName, null));
        final routeGetter = annotatedElement.annotation.peek("routeGetter").objectValue as RouteGetter;
        final route = routeGetter();
        int index = 0;
        route.forEach((key, value) => nameValues.addLine(buildRouteName(_formatLC2UU(key), key, index++ == 0)));
      }
    }
    return null;
  }

  String buildLine(String className, bool generatedRoute, String routeFieldName, String routeVariableName) =>
      generatedRoute ? "      ..._$routeVariableName.entries," : "      ...$className.$routeFieldName.entries,";

  String buildRouteParam(List<RoutePrarm> prarms) {
    final buffer = StringBuffer();
    if (prarms.length == 1) {
      buffer.write(prarmToString(prarms[0]));
    } else if (prarms.length > 1) {
      final indexPrarms = prarms.where((value) => !value.isOptional).toList();
      final optionalPrarms = prarms.where((value) => value.isOptional).toList()..sort();
      indexPrarms.forEach((prarm) => buffer.write(prarmToString(prarm)));
      optionalPrarms.forEach((prarm) => buffer.write(prarmToString(prarm)));
    }
    return buffer.toString();
  }

  List<RoutePrarm> mapPrarms(ConstantReader value) {
    return value?.listValue
            ?.map((value) => RoutePrarm(
                  key: value.getField("key").toStringValue(),
                  optionalName: value.getField("optionalName").toStringValue(),
                  isOptional: value.getField("isOptional").toBoolValue(),
                  // type: value.getField("type").toTypeValue() as Type,
                  // defaultValue: value.getField("defaultValue").isNull ? null : value.getField("defaultValue").toStringValue(),
                  index: value.getField("index").toIntValue(),
                ))
            ?.toList() ??
        <RoutePrarm>[];
  }

  String prarmToString(RoutePrarm prarm) {
    // final defaultValue = prarm.defaultValue != null ? "?? '${prarm.defaultValue}'," : ",";
    final defaultValue = ",";
    final value = prarm.key == null
        ? "settings.arguments $defaultValue"
        : "(settings.arguments as Map<String, dynamic>)['${prarm.key}'] $defaultValue";
    final write = prarm.isOptional ? "${prarm.optionalName} : $value" : value;
    return write;
  }

  String buildRoute(String routeVariableName, String routeName, String className, String prarms) =>
      "Map<String, RouteFactory> _$routeVariableName = <String, RouteFactory>{'$routeName': (RouteSettings settings) => MaterialPageRoute(builder: (BuildContext context) => $className($prarms))};";

  String buildRouteName(String routeConstantName, String routeName, bool isAlias) =>
      isAlias ? "const ROUTE_ALIAS_$routeConstantName = '$routeName';" : "const ROUTE_$routeConstantName = '$routeName';";
}

String _normalizeName(String name, [bool asRouteName = true]) {
  // String result;
  // if (name == "/") {
  //   if (asRouteName) {
  //     return "/";
  //   } else {
  //     result = "home";
  //   }
  // } else if (name[0] == "/") {
  //   result = name.replaceFirst(name[0], "");
  // }
  // result = result.replaceFirst(result[0], result[0].toLowerCase());
  // return result;

  final buffer = StringBuffer();
  final exp = RegExp("[A-Za-z0-9]");
  if (name == "/") return asRouteName ? "/" : "home";
  bool needToUpperCase = false;
  for (var i = 0; i < name.length; i++) {
    //忽略除字母数字外的符号
    if (!exp.hasMatch(name[i])) {
      needToUpperCase = true;
    } else {
      buffer.write(needToUpperCase ? name[i].toUpperCase() : name[i]);
      needToUpperCase = false;
    }
  }
  final result = buffer.toString();
  return result.replaceFirst(result[0], result[0].toLowerCase());
}

String _formatLC2UU(String text) => format(text, CaseFormat.LOWER_CAMEL, CaseFormat.UPPER_UNDERSCORE);
String _formatLC2LU(String text) => format(text, CaseFormat.LOWER_CAMEL, CaseFormat.LOWER_UNDERSCORE);
