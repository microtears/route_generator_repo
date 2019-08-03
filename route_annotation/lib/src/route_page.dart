import 'package:route_annotation/src/route_parameter.dart';

/// 此注解用来注解一个路由页面
///
/// * [name] 路由名称，建议采用下划线方式名称，例如`custom_route_name`，
/// 或是采用`/`分割的url路径，例如：`/library/music`。
/// * [isInitialRoute] 是否是初始化路由页面，如果值为`true`,
/// 那么将忽略自定义路由名称 [name] ，同时生成名为`ROUTE_HOME`的路由常量，
/// 需要注意的是：只允许有一个初始化路由页面。
/// * [params] 路由参数列表，详细请参照 [RouteParameter]。
///
/// 例如：
/// ```dart
/// @RoutePage(isInitialRoute: true)
/// class HomePage extends StatelessWidget {
///   @override
///   Widget build(BuildContext context) {
///     return Scaffold(body: Center(child: Text("Home Page")));
///   }
/// }
///```
class RoutePage {
  final String name;
  final bool isInitialRoute;
  final List<RouteParameter> params;

  const RoutePage({
    this.name,
    this.isInitialRoute = false,
    this.params = const [],
  });
}
