import 'package:example/app.route.dart';
import 'package:flutter/material.dart';
import 'package:route_annotation/route_annotation.dart';

@RoutePage()
class SecondPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Column(
          children: <Widget>[
            Text("SecondPage"),
            FlatButton(
              onPressed: () {
                Navigator.of(context).pushNamed(ROUTE_CUSTOM_ROUTE);
              },
              child: Text("Next Page"),
            ),
          ],
        ),
      ),
    );
  }
}
