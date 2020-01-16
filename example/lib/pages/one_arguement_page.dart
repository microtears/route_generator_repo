import 'package:flutter/material.dart';
import 'package:route_annotation/route_annotation.dart';

@RoutePage(params: [RouteParameter("title")])
class OneArgumentPage extends StatelessWidget {
  final String title;

  const OneArgumentPage({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
