// import 'package:flutter/material.dart';

// typedef RouteGetter = Map<String, RouteFactory> Function();
typedef RouteGetter = Map<String, dynamic> Function();

class RoutePage {
  final String name;
  final bool generatedRoute;
  final isInitialRoute;
  final String routeFieldName;
  final RouteGetter routeGetter;

  const RoutePage({
    this.name,
    this.generatedRoute = true,
    this.routeFieldName = "route",
    this.routeGetter,
    this.isInitialRoute = false,
  });
}
