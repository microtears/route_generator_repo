class RouteTransitionBuilderFunction {
  /// This annotation is used to identify the [TransitionBuilder] static
  /// method of a routing page. See [ModalRoute.buildTransitions] for details,
  /// but the difference is that [RouteTransitionBuilderFunction] provides
  /// [RouteSettings] parameter compared to [ModalRoute.buildTransitions].
  ///
  /// example:
  /// ```dart
  ///   @RouteTransitionBuilderFunction()
  ///   static Widget buildTransitions(
  ///        BuildContext context,
  ///        Animation<double> animation,
  ///        Animation<double> secondaryAnimation,
  ///        Widget child,
  ///        RouteSettings settings) =>
  ///    child;
  /// ```
  const RouteTransitionBuilderFunction();
}
