import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';
import 'package:route_annotation/route_annotation.dart';

import 'watch_state.dart';

const TypeChecker routeChecker = TypeChecker.fromRuntime(Router);

class RouteGenerator extends Generator {
  Set<String> imports = {};
  Set<String> routeMaps = {};
  Set<String> onGenerateRoute = {};
  Set<String> routeNames = {};
  bool hasInitialRoute = false;

  @override
  generate(LibraryReader library, BuildStep buildStep) async {
    if (library.annotatedWith(routeChecker).isNotEmpty) {
      return outputAsString();
    }
    if (rewrite) {
      // TODO(microtears) resolve UnexpectedOutputException
      // and rewrite route file;

      // UnexpectedOutputException: example|lib/app.route.dart
      // Expected only: {example|lib/home_page.route.dart}

      // final routeFile = Glob("**.route.dart");
      // final assetId =
      //     AssetId(buildStep.inputId.package, routeFile.listSync().first.path);
      // print("assetId is $assetId");
      // if (assetId != null) {
      //   buildStep.writeAsString(assetId, outputAsString());
      //   print("rewrite finished");
      // }

    }
    return null;
  }

  void perpare() {
    imports.add("import 'package:flutter/material.dart';");
    onGenerateRoute
        .add("RouteFactory onGenerateRoute = (settings) => Map.fromEntries([");
  }

  void finish() {
    imports.clear();
    routeMaps.clear();
    onGenerateRoute.clear();
    routeNames.clear();
    hasInitialRoute = false;
    rewrite = false;
  }

  String outputAsString() {
    perpare();
    routes.forEach((route) {
      if (route.isInitialRoute) {
        if (hasInitialRoute == true) {
          throw UnsupportedError(
              "There can only be one initialization page,${route.className}'s isInitialRoute should be false.");
        }
        hasInitialRoute = true;
      }
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
  }
}
