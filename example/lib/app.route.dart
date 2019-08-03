// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// RouteGenerator
// **************************************************************************

import 'package:flutter/material.dart';
import 'home_page.dart';
import 'custom_route_page.dart';
import 'custom_route_name_page.dart';
import 'second_page.dart';
import 'one_arguement_page.dart';
import 'two_arguement_page.dart';

const ROUTE_HOME = '/';
const ROUTE_CUSTOM_ROUTE_PAGE = 'custom_route_page';
const ROUTE_CUSTOM = 'custom';
const ROUTE_SECOND_PAGE = 'second_page';
const ROUTE_ONE_ARGUMENT_PAGE = 'one_argument_page';
const ROUTE_TWO_ARGUMENT_PAGE = 'two_argument_page';

RouteFactory onGenerateRoute = (settings) => Map.fromEntries([
      ..._home.entries,
      ..._customRoutePage.entries,
      ..._custom.entries,
      ..._secondPage.entries,
      ..._oneArgumentPage.entries,
      ..._twoArgumentPage.entries,
    ])[settings.name](settings);

Map<String, RouteFactory> _home = <String, RouteFactory>{
  '/': (RouteSettings settings) => MaterialPageRoute(
        builder: (BuildContext context) => HomePage(),
      ),
};
Map<String, RouteFactory> _customRoutePage = <String, RouteFactory>{
  'custom_route_page': (RouteSettings settings) => PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            CustomRoutePage.buildPage(
                context, animation, secondaryAnimation, settings),
        transitionsBuilder: (context, animation, secondaryAnimation, child) =>
            CustomRoutePage.buildTransitions(
                context, animation, secondaryAnimation, child, settings),
        transitionDuration: CustomRoutePage.transitionDuration,
      ),
};
Map<String, RouteFactory> _custom = <String, RouteFactory>{
  'custom': (RouteSettings settings) => MaterialPageRoute(
        builder: (BuildContext context) => CustomRoutePageName(),
      ),
};
Map<String, RouteFactory> _secondPage = <String, RouteFactory>{
  'second_page': (RouteSettings settings) => MaterialPageRoute(
        builder: (BuildContext context) => SecondPage(),
      ),
};
Map<String, RouteFactory> _oneArgumentPage = <String, RouteFactory>{
  'one_argument_page': (RouteSettings settings) => MaterialPageRoute(
        builder: (BuildContext context) =>
            OneArgumentPage(title: settings.arguments),
      ),
};
Map<String, RouteFactory> _twoArgumentPage = <String, RouteFactory>{
  'two_argument_page': (RouteSettings settings) => MaterialPageRoute(
        builder: (BuildContext context) => TwoArgumentPage(
              title: (settings.arguments as Map<String, dynamic>)['title'],
              subTitle:
                  (settings.arguments as Map<String, dynamic>)['subTitle'],
            ),
      ),
};
