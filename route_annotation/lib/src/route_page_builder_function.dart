/// 这个注解用来标识一个路由页面的[RoutePageBuilder]静态方法
/// 具体参见[ModalRoute.buildPage],但不同之处是相比[ModalRoute.buildPage]
/// [RoutePageBuilderFunction]提供了[RouteSettings]参数。
///
/// 例如：
/// ```dart
///   @RoutePageBuilderFunction()
///   static Widget buildPage(BuildContext context, Animation animation,
///           Animation secondaryAnimation, RouteSettings settings) =>
///       CustomRoutePage();
/// ```
///
class RoutePageBuilderFunction {
  const RoutePageBuilderFunction();
}
