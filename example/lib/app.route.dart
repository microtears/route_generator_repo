// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// RouteGenerator
// **************************************************************************

import 'package:flutter/material.dart';
import 'custom_route_name_page.dart';
import 'custom_route_page.dart';
import 'two_arguement_page.dart';
import 'home_page.dart';
import 'one_arguement_page.dart';
import 'second_page.dart';

const ROUTE_CUSTOM = 'custom';
const ROUTE_CUSTOM_ROUTE_PAGE = 'custom_route_page';
const ROUTE_TWO_ARGUMENT_PAGE = 'two_argument_page';
const ROUTE_HOME = '/';
const ROUTE_ONE_ARGUMENT_PAGE = 'one_argument_page';
const ROUTE_SECOND_PAGE = 'second_page';

RouteFactory onGenerateRoute = (settings) => Map.fromEntries([
      ..._custom.entries,
      ..._customRoutePage.entries,
      ..._twoArgumentPage.entries,
      ..._home.entries,
      ..._oneArgumentPage.entries,
      ..._secondPage.entries,
    ])[settings.name](settings);

Map<String, RouteFactory> _custom = <String, RouteFactory>{
  'custom': (RouteSettings settings) => MaterialPageRoute(
        builder: (BuildContext context) => CustomRoutePageName(),
      ),
};
Map<String, RouteFactory> _customRoutePage = CustomRoutePage.route;
Map<String, RouteFactory> _twoArgumentPage = <String, RouteFactory>{
  'two_argument_page': (RouteSettings settings) => MaterialPageRoute(
        builder: (BuildContext context) => TwoArgumentPage(),
      ),
};
Map<String, RouteFactory> _home = <String, RouteFactory>{
  '/': (RouteSettings settings) => MaterialPageRoute(
        builder: (BuildContext context) => HomePage(),
      ),
};
Map<String, RouteFactory> _oneArgumentPage = <String, RouteFactory>{
  'one_argument_page': (RouteSettings settings) => MaterialPageRoute(
        builder: (BuildContext context) => OneArgumentPage(),
      ),
};
Map<String, RouteFactory> _secondPage = <String, RouteFactory>{
  'second_page': (RouteSettings settings) => MaterialPageRoute(
        builder: (BuildContext context) => SecondPage(),
      ),
};
