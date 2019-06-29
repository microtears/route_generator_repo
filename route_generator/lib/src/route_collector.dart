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
        final name = isInitialRoute ? "/" : annotatedElement.annotation.peek("name")?.stringValue ?? "/$className";
        final prarms = mapPrarms(annotatedElement.annotation.peek("prarms"));
        if (isInitialRoute) {
          if (hasInitialRoute == true) {
            throw UnsupportedError("There can only be one initialization page,$name's isInitialRoute should be false");
          }
          hasInitialRoute = true;
        }
        routerValues.addLine(buildLine(className, generatedRoute, null, name));
        routerValues.addImport(import);
        pageValues.addRoute(buildRoute(name, className, buildRouteParam(prarms)));
        routerValues.addValues(pageValues);
        nameValues.addLine(buildRouteName(name, isAlias));
      } else {
        routerValues.addLine(buildLine(className, generatedRoute, routeFieldName, null));
        final routeGetter = annotatedElement.annotation.peek("routeGetter").objectValue as RouteGetter;
        final route = routeGetter();
        int index = 0;
        route.forEach((key, value) => nameValues.addLine(buildRouteName(key, index++ == 0)));
      }
    }
    return null;
  }

  String buildLine(String className, bool generatedRoute, String routeFieldName, String routeName) =>
      generatedRoute ? "      ..._${_formatLU2LC(routeName, false)}.entries," : "      ...$className.$routeFieldName.entries,";

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

  String buildRoute(String routeName, String routePageName, String prarms) =>
      "Map<String, RouteFactory> _${_formatLU2LC(routeName, false)} = <String, RouteFactory>{'${_formatLC2LU(routeName)}': (RouteSettings settings) => MaterialPageRoute(builder: (BuildContext context) => $routePageName($prarms))};";

  String buildRouteName(String routeName, bool isAlias) => isAlias
      ? "const ROUTE_ALIAS_${_formatLC2UU(routeName, false)} = '${_formatLC2LU(routeName)}';"
      : "const ROUTE_${_formatLC2UU(routeName, false)} = '${_formatLC2LU(routeName)}';";
}

String _normalizeRouteName(String routeName, [bool asRouteName = true]) {
  String result;
  if (routeName == "/")
    result = asRouteName ? "/" : "home";
  else if (routeName[0] == "/") {
    result = routeName.replaceFirst(routeName[0], "");
  }
  result = result.replaceFirst(routeName[0], routeName[0].toLowerCase());
  return result;
}

String _formatLC2UU(String routeName, [bool asRouteName = true]) =>
    format(_normalizeRouteName(routeName, asRouteName), CaseFormat.LOWER_CAMEL, CaseFormat.UPPER_UNDERSCORE);
String _formatLC2LU(String routeName, [bool asRouteName = true]) =>
    format(_normalizeRouteName(routeName, asRouteName), CaseFormat.LOWER_CAMEL, CaseFormat.LOWER_UNDERSCORE);
String _formatLU2LC(String routeName, [bool asRouteName = true]) =>
    format(_formatLC2LU(routeName, asRouteName), CaseFormat.LOWER_UNDERSCORE, CaseFormat.LOWER_CAMEL);
