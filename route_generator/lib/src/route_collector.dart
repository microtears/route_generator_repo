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
      // final package = buildStep.inputId.package;
      final generatedRoute = annotatedElement.annotation.peek("generatedRoute").boolValue;
      final import = path.contains('lib/') ? path.replaceFirst('lib/', '') : path;
      routerValues.addImport(import);
      if (generatedRoute) {
        final pageValues = Values();
        final isInitialRoute = annotatedElement.annotation.peek("isInitialRoute").boolValue;
        final name = isInitialRoute ? "/" : annotatedElement.annotation.peek("name")?.stringValue ?? "/$className";

        if (isInitialRoute) {
          if (hasInitialRoute == true) {
            throw UnsupportedError("There can only be one initialization page,$name's isInitialRoute should be false");
          }
          hasInitialRoute = true;
        }
        routerValues.addLine(buildLine(className, generatedRoute, null, name));
        routerValues.addImport(import);
        pageValues.addRoute(buildRoute(name, className));
        routerValues.addValues(pageValues);
        nameValues.addLine(buildRouteName(name, false));
      } else {
        routerValues.addLine(buildLine(className, generatedRoute, routeFieldName, null));
        final routeGetter = annotatedElement.annotation.peek("routeGetter").objectValue as RouteGetter;
        final route = routeGetter();
        int index = 0;
        route.forEach((key, value) => buildRouteName(key, index++ == 0));
      }
    }
    return null;
  }

  String buildLine(String className, bool generatedRoute, String routeFieldName, String routeName) =>
      generatedRoute ? "      ..._${_formatLU2LC(routeName)}.entries," : "      ...$className.$routeFieldName.entries,";

  String buildRoute(String routeName, String routePageName) =>
      "Map<String, RouteFactory> _${_formatLU2LC(routeName)} = <String, RouteFactory>{'${_formatLC2LU(routeName)}': (settings) => MaterialPageRoute(builder: (BuildContext context) => $routePageName())};";

  String buildRouteName(String routeName, bool isAlias) => isAlias
      ? "const ROUTE_ALIAS_${_formatLC2UU(routeName)} = '${_formatLC2LU(routeName)}';"
      : "const ROUTE_${_formatLC2UU(routeName)} = '${_formatLC2LU(routeName)}';";
}

String _normalizeRouteName(String routeName) {
  String result;
  if (routeName == "/")
    result = "home";
  else if (routeName[0] == "/") {
    result = routeName.replaceFirst(routeName[0], "");
  }
  result = result.replaceFirst(routeName[0], routeName[0].toLowerCase());
  return result;
}

String _formatLC2UU(String routeName) =>
    format(_normalizeRouteName(routeName), CaseFormat.LOWER_CAMEL, CaseFormat.UPPER_UNDERSCORE);
String _formatLC2LU(String routeName) =>
    format(_normalizeRouteName(routeName), CaseFormat.LOWER_CAMEL, CaseFormat.LOWER_UNDERSCORE);
String _formatLU2LC(String routeName) => format(_formatLC2LU(routeName), CaseFormat.LOWER_UNDERSCORE, CaseFormat.LOWER_CAMEL);
