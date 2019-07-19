import 'package:build/build.dart';
import 'package:route_annotation/route_annotation.dart';
import 'package:route_generator/src/string_case.dart';
import 'package:source_gen/source_gen.dart';

import 'route_generator.dart';
import 'values.dart';

class RouteCollector extends Generator {
  static const DEBUG = false;
  TypeChecker get pageChecker => TypeChecker.fromRuntime(RoutePage);
  bool hasInitialRoute = false;

  @override
  generate(LibraryReader library, BuildStep buildStep) async {
    final routerValues = RouteGenerator.routerValues;
    final nameValues = RouteGenerator.nameValues;
    //library.annotatedWith(pageChecker) 只获取同一注解的第一个，我们需要的是所有的注解
    for (var annotatedElement in _allElementWithChecker(library, pageChecker)) {
      final className = annotatedElement.element.displayName;
      final routeFieldName = annotatedElement.annotation.peek("routeFieldName").stringValue;
      final path = buildStep.inputId.path;
      final package = buildStep.inputId.package;
      final generatedRoute = annotatedElement.annotation.peek("generatedRoute").boolValue;
      final import = path.contains('lib/')
          ? path.replaceFirst('lib/', '')
          : "package:$package/${path.replaceFirst('lib/', '')}";
      routerValues.addImport(import);
      if (generatedRoute) {
        final pageValues = Values();
        final isInitialRoute = annotatedElement.annotation.peek("isInitialRoute").boolValue;
        final isAlias = annotatedElement.annotation.peek("isAlias").boolValue;
        //如果name为空则使用类名作为route name
        final peekName = annotatedElement.annotation.peek("name")?.stringValue ?? "/$className";
        //如果指定了为初始化界面则直接使route name为'/'，忽略自定义命名。
        // final name = isInitialRoute ? "/" : peekName;
        final name = isInitialRoute ? "home" : peekName;
        final prarms = mapPrarms(annotatedElement.annotation.peek("prarms"));
        //这里获取到的是LOWER_CAMEL标准的路由变量名称
        final routeVariableName = _normalizeName(name);
        final routeConstantName = _formatLC2UU(routeVariableName);
        final routeName = isInitialRoute ? "/" : _formatLC2LU(routeVariableName);

        if (DEBUG) {
          final debugValues = nameValues;
          debugValues.addRow("// className=$className");
          debugValues.addRow("// routeFieldName=$routeFieldName");
          debugValues.addRow("// path=$path");
          debugValues.addRow("// package=$package");
          debugValues.addRow("// generatedRoute=$generatedRoute");
          debugValues.addRow("// import=$import");
          debugValues.addRow("// isInitialRoute=$isInitialRoute");
          debugValues.addRow("// isAlias=$isAlias");
          debugValues.addRow("// peekName=$peekName");
          debugValues.addRow("// name=$name");
          debugValues.addRow("// peekName=$peekName");
          debugValues.addRow("// prarms=$prarms");
          debugValues.addRow("// routeVariableName=$routeVariableName");
          debugValues.addRow("// routeName=$routeName");
        }

        if (isInitialRoute) {
          if (hasInitialRoute == true) {
            throw UnsupportedError(
                "There can only be one initialization page,$name's isInitialRoute should be false");
          }
          hasInitialRoute = true;
        }
        routerValues.addRow(buildRow(className, generatedRoute, null, routeVariableName));
        routerValues.addImport(import);
        pageValues.addRoute(
            buildRoute(routeVariableName, routeName, className, buildRouteParam(prarms)));
        if (isInitialRoute) {
          //为home额外添加一个生成的路由
          nameValues
              .addRow(buildRouteName(_formatLC2UU(_normalizeName(peekName)), routeName, false));
        }
        routerValues.addValues(pageValues);
        nameValues.addRow(buildRouteName(routeConstantName, routeName, isAlias));
      } else {
        routerValues.addRow(buildRow(className, generatedRoute, routeFieldName, null));
        // type 'DartObjectImpl' is not a subtype of type 'RouteGetter' in type cast,
        // 自定义路由自动生成路由名称常量计划暂时搁置

        // final routeGetter = annotatedElement.annotation.peek("routeGetter").objectValue as RouteGetter;
        // final route = routeGetter();
        // int index = 0;
        // //拿到自义定路由Map中的所有路由，除第一个外，其余的全部定义为别名
        // route.forEach((key, value) => nameValues.addRow(buildRouteName(_formatLC2UU(key), key, index++ == 0)));
      }
    }
    return null;
  }

  String buildRow(String className, bool generatedRoute, String routeFieldName,
          String routeVariableName) =>
      generatedRoute
          ? "      ..._$routeVariableName.entries,"
          : "      ...$className.$routeFieldName.entries,";

  String buildRouteParam(List<RoutePrarm> prarms) {
    final buffer = StringBuffer();
    if (prarms.length == 1) {
      buffer.write(prarmToString(prarms[0]));
    } else if (prarms.length > 1) {
      final indexPrarms = prarms.where((value) => !value.isOptional).toList()..sort();
      final optionalPrarms = prarms.where((value) => value.isOptional).toList();
      indexPrarms.forEach((prarm) => buffer.write(prarmToString(prarm)));
      optionalPrarms.forEach((prarm) => buffer.write(prarmToString(prarm)));
    }
    return buffer.toString();
  }

  List<RoutePrarm> mapPrarms(ConstantReader value) {
    return value?.listValue?.map((value) {
          bool useNameAsKey = value.getField("useNameAsKey").toBoolValue();
          bool isOptional = value.getField("isOptional").toBoolValue();
          String key = value.getField("key").toStringValue();
          String name = value.getField("name").toStringValue();
          int index = value.getField("index").toIntValue();
          if (useNameAsKey && key == null) {
            key = name;
          }
          return RoutePrarm(key: key, name: name, isOptional: isOptional, index: index);
        })?.toList() ??
        <RoutePrarm>[];
  }

  String prarmToString(RoutePrarm prarm) {
    // final defaultValue = prarm.defaultValue != null ? "?? '${prarm.defaultValue}'," : ",";
    final defaultValue = ",";
    final value = prarm.key == null
        ? "settings.arguments $defaultValue"
        : "(settings.arguments as Map<String, dynamic>)['${prarm.key}'] $defaultValue";
    final write = prarm.isOptional ? "${prarm.name} : $value" : value;
    return write;
  }

  String buildRoute(
          String routeVariableName, String routeName, String className, String prarms) =>
      "Map<String, RouteFactory> _$routeVariableName = <String, RouteFactory>{'$routeName': (RouteSettings settings) => MaterialPageRoute(builder: (BuildContext context) => $className($prarms))};";

  String buildRouteName(String routeConstantName, String routeName, bool isAlias) => isAlias
      ? "const ROUTE_ALIAS_$routeConstantName = '$routeName';"
      : "const ROUTE_$routeConstantName = '$routeName';";
}

//将name转换为LOWER_CAMEL风格
String _normalizeName(String name) {
  final buffer = StringBuffer();
  final exp = RegExp("[A-Za-z0-9]");
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

String _formatLC2UU(String text) =>
    format(text, CaseFormat.LOWER_CAMEL, CaseFormat.UPPER_UNDERSCORE);
String _formatLC2LU(String text) =>
    format(text, CaseFormat.LOWER_CAMEL, CaseFormat.LOWER_UNDERSCORE);

/// All of the declarations in this library annotated with [checker].
Iterable<AnnotatedElement> _allElementWithChecker(LibraryReader library, TypeChecker checker,
    {bool throwOnUnresolved}) sync* {
  for (final element in library.allElements) {
    for (final annotation
        in checker.annotationsOf(element, throwOnUnresolved: throwOnUnresolved)) {
      yield AnnotatedElement(ConstantReader(annotation), element);
    }
  }
}
