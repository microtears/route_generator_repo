import 'package:build/build.dart';
import 'package:route_annotation/route_annotation.dart';
import 'package:source_gen/source_gen.dart';
import 'package:analyzer/dart/element/element.dart';

import 'real_route_page.dart';
import 'real_route_paramemter.dart';
import 'watch_state.dart';

const TypeChecker routePageChecker = TypeChecker.fromRuntime(RoutePage);
const TypeChecker routeGetterChecker = TypeChecker.fromRuntime(RouteField);
const TypeChecker pageRouteBuilderFuntcionChecker =
    TypeChecker.fromRuntime(PageRouteBuilderFuntcion);
const TypeChecker routePageBuilderFunctionChecker =
    TypeChecker.fromRuntime(RoutePageBuilderFunction);
const TypeChecker routeTransitionBuilderFunctionChecker =
    TypeChecker.fromRuntime(RouteTransitionBuilderFunction);
const TypeChecker routeTransitionDurationGetterChecker =
    TypeChecker.fromRuntime(RouteTransitionDurationField);

class RouteCollector extends Generator {
  static const DEBUG = false;

  @override
  generate(LibraryReader library, BuildStep buildStep) async {
    final inputId = buildStep.inputId.toString();
    if (fileRoutes[inputId] == null) {
      fileRoutes[inputId] = {};
    }
    final previous = Set<RealRoutePage>.from(fileRoutes[inputId]);
    fileRoutes[inputId].clear();
    for (var annotatedElement in library.annotatedWith(routePageChecker)) {
      final className = annotatedElement.element.displayName;
      final path = buildStep.inputId.path;
      final package = buildStep.inputId.package;
      final import = "package:$package/${path.replaceFirst('lib/', '')}";
      final route = resolveRoutePage(
          library.findType(className), annotatedElement.annotation, import);
      routes.add(route);
      fileRoutes[inputId].add(route);
    }
    rewrite = true;
    final current = fileRoutes[inputId];
    if (current.length < previous.length) {
      final differences = previous.difference(current);
      differences.forEach((removed) {
        routes.removeWhere((route) => route.routeName == removed.routeName);
      });
      if (differences.isNotEmpty) {
        rewrite = true;
      }
    }
    return null;
  }

  RealRoutePage resolveRoutePage(
      ClassElement classElement, ConstantReader annotation, String import) {
    final className = classElement.displayName;
    final isInitialRoute = annotation.peek("isInitialRoute").boolValue;

    final peekName = annotation.peek("name")?.stringValue ?? "/$className";
    final routeName = isInitialRoute ? "home" : peekName;

    List<RealRouteParameter> getPrarmters(ConstantReader value) {
      return value?.listValue
              ?.map((value) => RealRouteParameter(
                  value.getField("name").toStringValue(),
                  key: value.getField("key").toStringValue()))
              ?.toList() ??
          <RealRouteParameter>[];
    }

    routeGetterChecker.firstAnnotationOf(classElement);
    final methods = classElement.methods;
    final fields = classElement.fields;
    String findNeedStaticMethodName(
        List<MethodElement> methods, TypeChecker checker) {
      return methods
          .firstWhere(
            (method) => method.isStatic && checker.hasAnnotationOf(method),
            orElse: () => null,
          )
          ?.displayName;
    }

    String findNeedStaticFieldName(
        List<FieldElement> fields, TypeChecker checker) {
      return fields
          .firstWhere(
            (field) => field.isStatic && checker.hasAnnotationOf(field),
            orElse: () => null,
          )
          ?.displayName;
    }

    String routeField;
    String pageRouteBuilderFuntcion;
    String routePageBuilderFunction;
    String routeTransitionBuilderFunction;
    String routeTransitionDurationField;

    routeField = findNeedStaticFieldName(fields, routeGetterChecker);
    if (routeField == null)
      pageRouteBuilderFuntcion =
          findNeedStaticMethodName(methods, pageRouteBuilderFuntcionChecker);

    if (routeField == null && pageRouteBuilderFuntcion == null) {
      routePageBuilderFunction =
          findNeedStaticMethodName(methods, routePageBuilderFunctionChecker);
      routeTransitionBuilderFunction = findNeedStaticMethodName(
          methods, routeTransitionBuilderFunctionChecker);
      routeTransitionDurationField =
          findNeedStaticFieldName(fields, routeTransitionDurationGetterChecker);
    }

    return RealRoutePage(
      import,
      className,
      routeName,
      isInitialRoute: isInitialRoute,
      prarms: getPrarmters(annotation.peek("prarms")),
      routeField: routeField,
      pageRouteBuilderFuntcion: pageRouteBuilderFuntcion,
      routePageBuilderFunction: routePageBuilderFunction,
      routeTransitionBuilderFunction: routeTransitionBuilderFunction,
      routeTransitionDurationField: routeTransitionDurationField,
    );
  }
}
