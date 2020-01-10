import 'package:route_generator/src/string_case.dart';

import 'templete.dart';

/// Convert [name] to LOWER_CAMEL style
String normalizeName(String name) {
  final buffer = StringBuffer();
  final exp = RegExp("[A-Za-z0-9]");
  bool needToUpperCase = false;
  for (var i = 0; i < name.length; i++) {
    // ignore symbols other than alphanumeric
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

String formatLC2UU(String text) =>
    format(text, CaseFormat.LOWER_CAMEL, CaseFormat.UPPER_UNDERSCORE);

String formatLC2LU(String text) =>
    format(text, CaseFormat.LOWER_CAMEL, CaseFormat.LOWER_UNDERSCORE);

String replaceTemplate(
  String template,
  List<String> arguments, [
  String patten = contentTemplate,
]) {
  var i = -1;
  return template.replaceAllMapped(RegExp(patten), (_) {
    return arguments[++i];
  });
}

String buildOnGenerateRoute(List<String> routeVariables) {
  var items = routeVariables
      .map((e) => replaceTemplate(onGenerateRouteItemTemplate, [e]));
  return replaceTemplate(onGenerateRouteItemTemplate, items);
}

String buildRouteMap(
  String routeVariable, {
  Map<String, String> routeFactories,
  String customClassName,
}) {
  assert(routeFactories != null || customClassName != null);

  if (routeFactories != null) {
    return replaceTemplate(
      defaultRouteMapTemplate,
      [
        routeVariable,
        routeFactories.entries
            .map((e) => replaceTemplate(routeMapItemTemplate, [e.key, e.value]))
            .join(',')
      ],
    );
  } else {
    return replaceTemplate(
      customRouteMapTemplate,
      [routeVariable, customClassName],
    );
  }
}

String buildPage(String pageClassName, Map<String, String> arguments) {
  if (arguments.length == 1) {
    return replaceTemplate(
      singleArgumentConstructorTemplate,
      [pageClassName, arguments.keys.first, arguments[arguments.keys.first]],
    );
  } else {
    return replaceTemplate(
      multiArgumentConstructorTemplate,
      [
        pageClassName,
        arguments.entries
            .map((e) => replaceTemplate(
                  multiArgumentTemplate,
                  [e.key, e.value],
                ))
            .join(","),
      ],
    );
  }
}

String buildCustomPageRoute(String pageClassName) {
  return pageClassName;
}

String buildMaterialPageRoute(String page) {
  return replaceTemplate(materialPageRouteTemplate, [page]);
}

String buildPageRouteBuilder(
  String pageClassName,
  String pageBuilder, {
  String transitionsBuilder,
  String transitionDuration,
}) {
  var arguments = <String>[
    replaceTemplate(pageBuilderTemplate, [pageClassName, pageClassName]),
  ];
  if (transitionsBuilder != null) {
    arguments.add(replaceTemplate(
        transitionsBuilderTemplate, [pageClassName, transitionsBuilder]));
  }
  if (transitionDuration != null) {
    arguments.add(replaceTemplate(
        transitionDurationTemplate, [pageClassName, transitionDuration]));
  }
  return replaceTemplate(pageRouteBuilderTemplate, [arguments.join(',')]);
}

String buildImport(String path) {
  return replaceTemplate(importTemplate, [path]);
}
