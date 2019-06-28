class Values {
  Set<String> _imports = {};
  Set<String> _body = {};
  Set<Values> _subValues = {};

  addImport(String value) => _imports.add("import '$value';\n");
  addLine(String value) => _body.add(value + "\n");
  addRoute(String value) => addLine(value);

  addValues(Values values) => _subValues.add(values);

  clear() {
    _imports.clear();
    _body.clear();
  }

  _writeImport(StringBuffer buffer) {
    buffer.write(_imports.join());
    _subValues.forEach((value) {
      value._writeImport(buffer);
    });
  }

  _writeBody(StringBuffer buffer) {
    buffer.write(_body.join());
    _subValues.forEach((value) {
      value._writeBody(buffer);
    });
  }

  @override
  String toString() {
    StringBuffer buffer = StringBuffer();
    _writeImport(buffer);
    buffer.write("\n\n");
    _writeBody(buffer);
    return buffer.toString();
  }
}
