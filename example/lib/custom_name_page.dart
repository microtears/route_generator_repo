import 'package:flutter/material.dart';
import 'package:route_annotation/route_annotation.dart';

@RoutePage(name: "/custom")
class NamedPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text("this is a named page."),
      ),
    );
  }
}
