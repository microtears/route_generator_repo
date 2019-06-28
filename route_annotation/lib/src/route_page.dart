// import 'package:flutter/material.dart';

// typedef RouteGetter = Map<String, RouteFactory> Function();
import 'route_prarm.dart';

typedef RouteGetter = Map<String, dynamic> Function();

class RoutePage {
  final String name;
  final bool generatedRoute;
  final bool isInitialRoute;
  final bool isAlias;
  final String routeFieldName;
  final RouteGetter routeGetter;
  final List<RoutePrarm> prarms;

  // "If generatedRoute==false, you must provide routeGetter to generate route."
  // : assert(generatedRoute == false && routeGetter != null)
  const RoutePage({
    this.name,
    this.generatedRoute = true,
    this.routeFieldName = "route",
    this.routeGetter,
    this.isInitialRoute = false,
    this.isAlias = false,
    this.prarms = const <RoutePrarm>[],
  });
}
