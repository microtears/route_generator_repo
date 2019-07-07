import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';
import 'package:route_annotation/route_annotation.dart';

import 'values.dart';

class RouteGenerator extends Generator {
  TypeChecker get routeChecker => TypeChecker.fromRuntime(Router);

  static final nameValues = Values()..addRow("\n");

  static final routerValues = Values()
    ..addImport("package:flutter/material.dart")
    ..addRow("RouteFactory onGenerateRoute = (settings) => Map.fromEntries([");

  @override
  generate(LibraryReader library, BuildStep buildStep) async {
    if (library.annotatedWith(routeChecker).isNotEmpty) {
      // add last line
      routerValues.addRow("])[settings.name](settings);");
      routerValues.addRow("\n");
      routerValues.addValues(nameValues);
      final result = routerValues.toString();
      //reset
      nameValues
        ..clear()
        ..addRow("\n");
      routerValues
        ..clear()
        ..addImport("package:flutter/material.dart")
        ..addRow("RouteFactory onGenerateRoute = (settings) => Map.fromEntries([");
      // return "const result='''\n" + result + "\n''';";
      return result;
    }
    return null;
  }
}
