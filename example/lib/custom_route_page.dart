import 'package:flutter/material.dart';
import 'package:route_annotation/route_annotation.dart';

@RoutePage()
class CustomRoutePage extends StatelessWidget {
  @RouteField()
  static Map<String, RouteFactory> route = <String, RouteFactory>{
    'custom_route': (RouteSettings settings) =>
        MaterialPageRoute(builder: (BuildContext context) => CustomRoutePage()),
    'alias_route': (RouteSettings settings) => PageRouteBuilder(
          pageBuilder: (BuildContext context, Animation animation,
                  Animation secondaryAnimation) =>
              CustomRoutePage(),
        ),
  };

  @RoutePageBuilderFunction()
  static Widget buildPage(BuildContext context, Animation animation,
          Animation secondaryAnimation, RouteSettings settings) =>
      CustomRoutePage();

  @RouteTransitionBuilderFunction()
  static Widget buildTransitions(
          BuildContext context,
          Animation<double> animation,
          Animation<double> secondaryAnimation,
          Widget child,
          RouteSettings settings) =>
      child;

  @RouteTransitionDurationField()
  static Duration transitionDuration = Duration(milliseconds: 400);

  // @PageRouteBuilderFuntcion()
  static Route buildPageRoute(RouteSettings settings) => PageRouteBuilder(
        pageBuilder: (BuildContext context, Animation animation,
                Animation secondaryAnimation) =>
            CustomRoutePage(),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("CustomRoutePage"),
      ),
    );
  }
}
