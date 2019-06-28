import 'package:example/app.route.dart';
import 'package:flutter/material.dart';
import 'package:route_annotation/route_annotation.dart';

@Router()
class DemoApp extends StatefulWidget {
  @override
  _DemoAppState createState() => _DemoAppState();
}

class _DemoAppState extends State<DemoApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: "/",
      onGenerateRoute: onGenerateRoute,
    );
  }
}

String routeName(Map<String, RouteFactory> route, {String alias}) => alias == null ? route.keys.first : route[alias];
