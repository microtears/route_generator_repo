import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';
import 'package:route_annotation/route_annotation.dart';

import 'real_route_page.dart';

const TypeChecker routeChecker = TypeChecker.fromRuntime(Router);

class RouteGenerator extends Generator {
  Set<String> imports;
  Set<String> routeMaps;
  Set<String> onGenerateRoute;
  Set<String> routeNames;
  static final routes = <RealRoutePage>{};

  void perpare() {
    imports = {};
    routeMaps = {};
    onGenerateRoute = {};
    routeNames = {};
    imports.add("import 'package:flutter/material.dart';");
    onGenerateRoute
        .add("RouteFactory onGenerateRoute = (settings) => Map.fromEntries([");
  }

  void finish() {
    imports = null;
    routeMaps = null;
    onGenerateRoute = null;
    routeNames = null;
    routes.clear();
  }

  @override
  generate(LibraryReader library, BuildStep buildStep) async {
    if (library.annotatedWith(routeChecker).isNotEmpty) {
      perpare();
      routes.forEach((route) {
        imports.add("import '${route.import}';");
        routeMaps.add(route.buildRoute());
        routeNames.add(route.buildRouteName());
        onGenerateRoute.add(route.buildRouteEntries());
      });
      onGenerateRoute.add("])[settings.name](settings);\n");
      final result = imports.join("\n") +
          "\n\n" +
          routeNames.join("\n") +
          "\n\n" +
          onGenerateRoute.join("\n") +
          "\n\n" +
          routeMaps.join("\n") +
          "\n";
      finish();
      return result;
      // return "const result='''\n" + result + "\n''';";
    }
    return null;
  }
}
