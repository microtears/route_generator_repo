import 'package:example/alias_name_page.dart';
import 'package:flutter/material.dart';
import 'package:route_annotation/route_annotation.dart';

@RoutePage(generatedRoute: false, routeGetter: CustomRouteName.route, routeFieldName: "customRouteName")
class CustomRouteName extends StatelessWidget {
  static Map<String, RouteFactory> customRouteName = <String, RouteFactory>{
    'custom_route_name': (RouteSettings settings) => MaterialPageRoute(builder: (BuildContext context) => AliasNamePage()),
    'custom_route_name_alias': (RouteSettings settings) =>
        MaterialPageRoute(builder: (BuildContext context) => AliasNamePage()),
  };

  static route() => customRouteName;

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
