class RealRouteParameter {
  String key;
  String name;

  RealRouteParameter(this.name, {this.key}) : assert(name != null);

  @override
  String toString() {
    return "$runtimeType(key: $key,name: $name)";
  }
}
