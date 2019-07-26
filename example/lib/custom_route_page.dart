import 'package:flutter/material.dart';
import 'package:route_annotation/route_annotation.dart';

@RoutePage(generatedRoute: false, routeFieldName: "route")
class CustomRouteName extends StatelessWidget {
  static Map<String, RouteFactory> route = <String, RouteFactory>{
    'custom_route': (RouteSettings settings) =>
        MaterialPageRoute(builder: (BuildContext context) => CustomRouteName()),
    'alias_vr': (RouteSettings settings) =>
        MaterialPageRoute(builder: (BuildContext context) => CustomRouteName()),
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("CustomRoutePage"),
      ),
    );
  }
}
