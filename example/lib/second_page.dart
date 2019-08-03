import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:route_annotation/route_annotation.dart';

import 'app.route.dart';

@RoutePage()
class SecondPage extends StatelessWidget {
  final _titleController = TextEditingController();
  final _subTitleController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Second Page"),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                controller: _titleController,
                decoration: InputDecoration(
                    border: InputBorder.none, labelText: "Title"),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                controller: _subTitleController,
                decoration: InputDecoration(
                    border: InputBorder.none, labelText: "SubTitle"),
              ),
            ),
            FlatButton(
              onPressed: () {
                Navigator.of(context).pushNamed(
                  ROUTE_TWO_ARGUMENT_PAGE,
                  arguments: {
                    "title": _titleController.text.isNotEmpty
                        ? _titleController.text
                        : "title is empty",
                    "subTitle": _subTitleController.text.isNotEmpty
                        ? _subTitleController.text
                        : "sub title is empty",
                  },
                );
              },
              child: Text("Go to Argument Page"),
            ),
          ],
        ),
      ),
    );
  }
}
