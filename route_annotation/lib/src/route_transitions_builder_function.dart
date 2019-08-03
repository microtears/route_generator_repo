/// 这个注解用来标识一个路由页面的[TransitionBuilder]静态方法
/// 具体参见[ModalRoute.buildTransitions],但不同之处是相比[ModalRoute.buildTransitions]
/// [RouteTransitionBuilderFunction]提供了[RouteSettings]参数。
///
/// 例如：
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
class RouteTransitionBuilderFunction {
  const RouteTransitionBuilderFunction();
}
