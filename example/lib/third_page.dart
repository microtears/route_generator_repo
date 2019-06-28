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
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Previous Page"),
            ),
          ],
        ),
      ),
    );
  }
}
