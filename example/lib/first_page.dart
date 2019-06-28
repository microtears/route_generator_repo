import 'package:flutter/material.dart';
import 'package:route_annotation/route_annotation.dart';

@RoutePage(isInitialRoute: true)
class FirstPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Column(
          children: <Widget>[
            Text("FirstPage"),
            FlatButton(
              onPressed: () {},
              child: Text("Next Page"),
            ),
          ],
        ),
      ),
    );
  }
}
