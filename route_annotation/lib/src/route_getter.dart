class RouteField {
  /// This annotation is used to mark a completely custom route,
  /// and the annotated object must be used as a static field
  /// of the route page class.
  ///
  /// example:
  /// ```dart
  ///   @RouteField()
  ///   static Map<String, RouteFactory> route = <String, RouteFactory>{
  ///     'custom_route': (RouteSettings settings) =>
  ///         MaterialPageRoute(builder: (BuildContext context) => CustomRoutePage()),
  ///     'alias_route': (RouteSettings settings) =>
  ///         MaterialPageRoute(builder: (BuildContext context) => CustomRoutePage()),
  ///   };
  /// ```
  ///
  const RouteField();
}
