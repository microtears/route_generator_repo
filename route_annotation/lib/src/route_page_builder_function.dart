class RoutePageBuilderFunction {
  /// This annotation is used to identify the [RoutePageBuilder] static
  /// method of a routing page.See [ModalRoute.buildPage] for details,
  /// but the difference is that compared to [ModalRoute.buildPage],
  /// [RoutePageBuilderFunction] provides the [RouteSettings] parameter.
  ///
  /// example:
  /// ```dart
  ///   @RoutePageBuilderFunction()
  ///   static Widget buildPage(BuildContext context, Animation animation,
  ///           Animation secondaryAnimation, RouteSettings settings) =>
  ///       CustomRoutePage();
  /// ```
  ///
  const RoutePageBuilderFunction();
}
