import 'package:analyzer/dart/element/element.dart';
import 'package:source_gen/source_gen.dart';

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

String findStaticMethodNameByType(
    List<MethodElement> methods, TypeChecker checker) {
  return methods
      .firstWhere(
        (method) => method.isStatic && checker.hasAnnotationOf(method),
        orElse: () => null,
      )
      ?.displayName;
}

String findStaticFieldNameByType(
    List<FieldElement> fields, TypeChecker checker) {
  return fields
      .firstWhere(
        (field) => field.isStatic && checker.hasAnnotationOf(field),
        orElse: () => null,
      )
      ?.displayName;
}
