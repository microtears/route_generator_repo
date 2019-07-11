// import 'package:flutter/material.dart';

// typedef RouteGetter = Map<String, RouteFactory> Function();
import 'route_prarm.dart';

// typedef RouteGetter = Map<String, dynamic> Function();

class RoutePage {
  final String name;
  final bool generatedRoute;
  final bool isInitialRoute;
  final bool isAlias;
  final String routeFieldName;
  // final RouteGetter routeGetter;
  final List<RoutePrarm> prarms;

  /// 此注解用来注解一个路由页面
  ///
  /// * [name] 路由名称，建议采用下划线方式名称，例如`custom_route_name`，或是采用`/`分割的url路径，例如：`/library/music`。
  /// * [generatedRoute] 是否自动生成路由，如果值为`false`,需要手动编写路由页面代码，同时指定自定义路由字段名称 [routeFieldName]。
  /// * [isInitialRoute] 是否是初始化路由页面，如果值为`true`,那么将忽略自定义路由名称 [name] ，同时生成名为`ROUTE_HOME`的路由常量，需要注意的是：只允许有一个初始化路由页面。
  /// * [isAlias] 是否是别名
  /// * [routeFieldName] 自定义路由字段名称，默认值为`route`，自定义路由时需要确认此值。
  /// * [prarms] 路由参数列表，详细请参照 [RoutePrarm]。

  // "If generatedRoute==false, you must provide routeGetter to generate route."
  // : assert(generatedRoute == false && routeGetter != null)
  const RoutePage({
    this.name,
    this.generatedRoute = true,
    this.routeFieldName = "route",
    // this.routeGetter,
    this.isInitialRoute = false,
    this.isAlias = false,
    this.prarms = const <RoutePrarm>[],
  });
}
