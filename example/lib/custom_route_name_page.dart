import 'package:flutter/material.dart';
import 'package:route_annotation/route_annotation.dart';

@RoutePage(name: "/custom")
class CustomRouteNamePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Custom"),
      ),
      body: Center(
        child: Text("route name is custom"),
      ),
    );
  }
}
