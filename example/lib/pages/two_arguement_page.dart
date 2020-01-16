import 'package:flutter/material.dart';
import 'package:route_annotation/route_annotation.dart';

@RoutePage(params: [RouteParameter("title"), RouteParameter("subTitle")])
class TwoArgumentPage extends StatelessWidget {
  final String title;
  final String subTitle;

  TwoArgumentPage({this.title, Key key, this.subTitle}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                title,
                style: TextStyle(fontSize: 60, fontWeight: FontWeight.bold),
              ),
              Text(
                subTitle,
                style: TextStyle(fontSize: 40),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
