// 将name转换为LOWER_CAMEL风格
import 'package:route_generator/src/string_case.dart';

String normalizeName(String name) {
  final buffer = StringBuffer();
  final exp = RegExp("[A-Za-z0-9]");
  bool needToUpperCase = false;
  for (var i = 0; i < name.length; i++) {
    // 忽略除字母数字外的符号
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
