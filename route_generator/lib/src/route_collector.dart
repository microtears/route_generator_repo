import 'package:build/build.dart';
import 'package:route_annotation/route_annotation.dart';
import 'package:route_generator/src/real_route_paramemter.dart';
import 'package:source_gen/source_gen.dart';
import 'package:analyzer/dart/element/element.dart';

import 'real_route_page.dart';
import 'route_generator.dart';

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

final routes = RouteGenerator.routes;

class RouteCollector extends Generator {
  static const DEBUG = true;

  bool hasInitialRoute = false;

  @override
  generate(LibraryReader library, BuildStep buildStep) async {
    for (var annotatedElement in library.annotatedWith(routePageChecker)) {
      final className = annotatedElement.element.displayName;
      final path = buildStep.inputId.path;
      final package = buildStep.inputId.package;
      final import = path.contains('lib/')
          ? path.replaceFirst('lib/', '')
          : "package:$package/${path.replaceFirst('lib/', '')}";
      final route = resolveRoutePage(
          library.findType(className), annotatedElement.annotation, import);
      routes.add(route);
    }
    return null;
  }

  RealRoutePage resolveRoutePage(
      ClassElement classElement, ConstantReader annotation, String import) {
    final className = classElement.displayName;
    final isInitialRoute = annotation.peek("isInitialRoute").boolValue;
    if (isInitialRoute) {
      if (hasInitialRoute == true) {
        throw UnsupportedError(
            "There can only be one initialization page,$className's isInitialRoute should be false");
      }
      hasInitialRoute = true;
    }
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
