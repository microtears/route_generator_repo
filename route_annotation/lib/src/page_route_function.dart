/// 这个注解用来标识一个路由页面的[RouteFactory]静态方法
///
/// 例如：
/// ```dart
///  @PageRouteBuilderFuntcion()
///  static Route buildPageRoute(RouteSettings settings) => PageRouteBuilder(
///        pageBuilder: (BuildContext context, Animation animation,
///                Animation secondaryAnimation) =>
///            CustomRoutePage(),
///      );
/// ```
class PageRouteBuilderFuntcion {
  const PageRouteBuilderFuntcion();
}
