import 'package:flutter/material.dart';
import 'package:route_annotation/route_annotation.dart';

@RoutePage()
@RoutePage(isAlias: true, name: "/fun")
class AliasNamePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
