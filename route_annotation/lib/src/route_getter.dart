/// 此注解用来标志一个完全自定义的路由，被注解的对象必须作为路由页面类静态字段
///
/// 例如：
/// ```dart
///   @RouteField()
///   static Map<String, RouteFactory> route = <String, RouteFactory>{
///     'custom_route': (RouteSettings settings) =>
///         MaterialPageRoute(builder: (BuildContext context) => CustomRoutePage()),
///     'alias_route': (RouteSettings settings) =>
///         MaterialPageRoute(builder: (BuildContext context) => CustomRoutePage()),
///   };
/// ```
/// 如果需要获取路由key，可以通过以下函数实现：
/// ```dart
/// String routeName(Map<String, RouteFactory> route, {String alias}) =>
///     alias == null ? route.keys.first : route[alias];
/// ```
class RouteField {
  const RouteField();
}
