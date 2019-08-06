class RouteTransitionDurationField {
  /// This annotation is used to identify the transition time
  /// of a custom routing page.
  ///
  /// example:
  /// ```dart
  ///   @RouteTransitionDurationField()
  ///   static Duration transitionDuration = Duration(milliseconds: 400);
  /// ```
  /// warning：
  /// The annotation must be a static member of the class
  const RouteTransitionDurationField();
}
