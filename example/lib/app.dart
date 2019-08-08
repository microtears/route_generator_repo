import 'package:flutter/material.dart';
import 'package:route_annotation/route_annotation.dart';
import 'package:example_library/example_library.dart';

import 'app.route.dart';

final route = {
  "library_route":
      MaterialPageRoute(builder: (BuildContext context) => LibraryPage()),
};

@Router()
class DemoApp extends StatefulWidget {
  @override
  _DemoAppState createState() => _DemoAppState();
}

class _DemoAppState extends State<DemoApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: "/",
      onGenerateRoute: onGenerateRoute,
    );
  }
}
