import 'package:flutter/material.dart';
import 'package:route_annotation/route_annotation.dart';

@RoutePage(name: "/custom_route")
class ThirdPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Column(
          children: <Widget>[
            Text("SecondPage"),
            FlatButton(
              onPressed: () {},
              child: Text("Previous Page"),
            ),
          ],
        ),
      ),
    );
  }
}
