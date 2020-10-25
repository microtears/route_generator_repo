// GENERATED CODE - DO NOT MODIFY BY HAND

import 'package:flutter/material.dart';


RouteFactory routeFactory = _onGenerateRoute;

const ROUTE_CUSTOM = 'custom';
const ROUTE_HOME = '/';
const ROUTE_ONE_ARGUMENT_PAGE = 'one_argument_page';
const ROUTE_SECOND_PAGE = 'second_page';
const ROUTE_TWO_ARGUMENT_PAGE = 'two_argument_page';


Route<dynamic> _onGenerateRoute(RouteSettings settings) {
  Route<dynamic> route;
  Widget page;
  switch (settings.name) {
    case ROUTE_HOME:
      page = MyHomePage();
      break;
    case ROUTE_PHOTO:
      page = PhotoPage(picture: settings.arguments);
      break;
  }
  switch (settings.name) {
    case ROUTE_PHOTO:
      route = PageRouteBuilder(
        pageBuilder: (_, animation, animation2) => page,
        fullscreenDialog: true,
        opaque: false,
        transitionDuration: const Duration(milliseconds: 600),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return SharedAxisTransition(
            animation: animation,
            secondaryAnimation: secondaryAnimation,
            transitionType: SharedAxisTransitionType.vertical,
            child: child,
            fillColor: Colors.transparent,
          );
        },
      );
      break;
    default:
      route = MaterialPageRoute(
        builder: (BuildContext context) => page,
        settings: settings,
      );
  }
  return route;
}
//
// final RouteFactory _onGenerateRoute = (settings) => <String, RouteFactory>{
//   ROUTE_CUSTOM: (RouteSettings settings) => MaterialPageRoute(
//     builder: (BuildContext context) {
//       return Container();
//     },
//   ),
//   ROUTE_HOME: (RouteSettings settings) => MaterialPageRoute(
//     builder: (BuildContext context) {
//       return Container();
//     },
//   ),
//   ROUTE_ONE_ARGUMENT_PAGE: (RouteSettings settings) => MaterialPageRoute(
//     builder: (BuildContext context) {
//       return Container();
//     },
//   ),
//   ROUTE_SECOND_PAGE: (RouteSettings settings) => MaterialPageRoute(
//     builder: (BuildContext context) {
//       return Container();
//     },
//   ),
//   ROUTE_TWO_ARGUMENT_PAGE: (RouteSettings settings) => MaterialPageRoute(
//     builder: (BuildContext context) {
//       final arguments = settings.arguments as Map<String, dynamic>;
//       return Container();
//     },
//   ),
//
// }[settings.name](settings);

