class RoutePrarm<T> implements Comparable<RoutePrarm> {
  final String key;
  final String optionalName;
  final bool isOptional;
  final Type type;
  final T defaultValue;
  final int index;

  //: assert((isOptional == true && optionalName != null) || (isOptional == false && index != null))
  const RoutePrarm({
    this.key,
    this.optionalName,
    this.isOptional = true,
    this.type,
    this.defaultValue,
    this.index,
  });

  @override
  int compareTo(RoutePrarm other) => index.compareTo(other.index);
}

Type typeOf<T>() => T;
