import 'package:flutter/material.dart';
import 'package:route_annotation/route_annotation.dart';

@RoutePage(name: "/custom_route", prarms: [
  RoutePrarm(defaultValue: "defaultValue", isOptional: false, index: 0),
  RoutePrarm(key: "secondKey", optionalName: "secondValue"),
])
class ThirdPage extends StatelessWidget {
  final String firstValue;
  final int secondValue;

  ThirdPage(this.firstValue, {this.secondValue});

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
