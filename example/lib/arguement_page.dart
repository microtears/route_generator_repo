import 'package:flutter/material.dart';
import 'package:route_annotation/route_annotation.dart';

@RoutePage(prarms: [
  RoutePrarm(isOptional: false, index: 0, key: "title"),
  RoutePrarm(name: "subTitle"),
])
class ArgumentPage extends StatelessWidget {
  final String title;
  final String subTitle;

  ArgumentPage(this.title, {Key key, this.subTitle}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}