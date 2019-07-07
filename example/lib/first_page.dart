import 'package:example/app.route.dart';
import 'package:flutter/material.dart';
import 'package:route_annotation/route_annotation.dart';

@RoutePage(isInitialRoute: true)
class FirstPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("First Page"),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            RaisedButton(
              onPressed: () {
                Navigator.of(context).pushNamed(ROUTE_SECOND_PAGE);
              },
              child: Text("Next Page"),
            ),
            RaisedButton(
              onPressed: () {
                Navigator.of(context).pushNamed(ROUTE_ALIAS_FUN);
              },
              child: Text("Go to Alias Page"),
            ),
            RaisedButton(
              onPressed: () {
                Navigator.of(context).pushNamed(ROUTE_CUSTOM);
              },
              child: Text("Go to CustomRouteName Page"),
            ),
            RaisedButton(
              onPressed: () {
                Navigator.of(context).pushNamed("custom_route");
              },
              child: Text("Go to CustomRoute Page"),
            ),
          ],
        ),
      ),
    );
  }
}
