// import 'package:flutter/material.dart';
import 'package:glob/glob.dart';
// import 'app.dart';

// void main() => runApp(DemoApp());
void main() {
  final dartFile = new Glob("**.route.dart");
  for (var entity in dartFile.listSync()) {
    print(entity.path);
  }
}
