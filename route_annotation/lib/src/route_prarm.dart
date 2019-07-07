class RoutePrarm<T> implements Comparable<RoutePrarm> {
  final String key;
  final String name;
  final bool isOptional;
  // final Type type;
  // final T defaultValue;
  final int index;

  //: assert((isOptional == true && optionalName != null) || (isOptional == false && index != null))
  const RoutePrarm({
    this.key,
    this.name,
    this.isOptional = true,
    // this.type,
    // this.defaultValue,
    this.index,
  });

  @override
  int compareTo(RoutePrarm other) => index.compareTo(other.index);
}

// Type typeOf<T>() => T;
