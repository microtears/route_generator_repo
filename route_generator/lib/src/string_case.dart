enum CaseFormat {
  UPPER_UNDERSCORE,
  LOWER_UNDERSCORE,
  LOWER_CAMEL,
}

String format(String value, CaseFormat from, CaseFormat to) {
  if (from == CaseFormat.LOWER_CAMEL && (to == CaseFormat.UPPER_UNDERSCORE || to == CaseFormat.LOWER_UNDERSCORE)) {
    final buffer = StringBuffer();
    final exp = RegExp("[A-Z]");
    final lower = RegExp("[a-z]");
    for (var i = 0; i < value.length; i++) {
      final char = value[i];
      if (i != 0 && lower.hasMatch(value[i - 1]) && exp.hasMatch(char)) {
        buffer.write("_");
      }
      if (to == CaseFormat.UPPER_UNDERSCORE)
        buffer.write(char.toUpperCase());
      else
        buffer.write(char.toLowerCase());
    }
    return buffer.toString();
  } else if (from == CaseFormat.LOWER_UNDERSCORE && to == CaseFormat.LOWER_CAMEL) {
    if (RegExp("[0-9]").hasMatch(value[0])) throw ArgumentError("The first character cannot be a number");
    final buffer = StringBuffer();
    final exp = RegExp("[A-Za-z0-9]");
    for (var i = 0; i < value.length; i++) {
      final char = value[i];
      if (i != 0 && "_" == value[i - 1] && exp.hasMatch(char)) {
        buffer.write(char.toUpperCase());
      } else if (char != "_") {
        buffer.write(char.toLowerCase());
      }
    }
    return buffer.toString();
  }
  throw UnimplementedError("Not yet implemented");
}
