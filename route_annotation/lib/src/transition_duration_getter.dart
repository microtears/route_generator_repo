/// 这个注解用来标识一个自定义路由页面的过渡时长
///
/// 例如：
/// ```dart
///   @RouteTransitionDurationField()
///   static Duration transitionDuration = Duration(milliseconds: 400);
/// ```dart
/// 注意：
/// 被注解的必须是类的静态成员
class RouteTransitionDurationField {
  const RouteTransitionDurationField();
}
