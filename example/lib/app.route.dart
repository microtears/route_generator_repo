// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// RouteGenerator
// **************************************************************************

import 'package:flutter/material.dart';
import 'package:example_library/example_library.dart';
import 'package:example/custom_route_name_page.dart';
import 'package:example/one_arguement_page.dart';
import 'package:example/custom_route_page.dart';
import 'package:example/home_page.dart';
import 'package:example/second_page.dart';
import 'package:example/two_arguement_page.dart';

const ROUTE_LIBRARY_PAGE = 'library_page';
const ROUTE_CUSTOM = 'custom';
const ROUTE_ONE_ARGUMENT_PAGE = 'one_argument_page';
const ROUTE_CUSTOM_ROUTE_PAGE = 'custom_route_page';
const ROUTE_HOME = '/';
const ROUTE_SECOND_PAGE = 'second_page';
const ROUTE_TWO_ARGUMENT_PAGE = 'two_argument_page';

RouteFactory onGenerateRoute = (settings) => Map.fromEntries([
      ..._libraryPage.entries,
      ..._custom.entries,
      ..._oneArgumentPage.entries,
      ..._customRoutePage.entries,
      ..._home.entries,
      ..._secondPage.entries,
      ..._twoArgumentPage.entries,
    ])[settings.name](settings);

Map<String, RouteFactory> _libraryPage = <String, RouteFactory>{
  'library_page': (RouteSettings settings) => MaterialPageRoute(
        builder: (BuildContext context) => LibraryPage(),
      ),
};
Map<String, RouteFactory> _custom = <String, RouteFactory>{
  'custom': (RouteSettings settings) => MaterialPageRoute(
        builder: (BuildContext context) => CustomRoutePageName(),
      ),
};
Map<String, RouteFactory> _oneArgumentPage = <String, RouteFactory>{
  'one_argument_page': (RouteSettings settings) => MaterialPageRoute(
        builder: (BuildContext context) =>
            OneArgumentPage(title: settings.arguments),
      ),
};
Map<String, RouteFactory> _customRoutePage = CustomRoutePage.route;
Map<String, RouteFactory> _home = <String, RouteFactory>{
  '/': (RouteSettings settings) => MaterialPageRoute(
        builder: (BuildContext context) => HomePage(),
      ),
};
Map<String, RouteFactory> _secondPage = <String, RouteFactory>{
  'second_page': (RouteSettings settings) => MaterialPageRoute(
        builder: (BuildContext context) => SecondPage(),
      ),
};
Map<String, RouteFactory> _twoArgumentPage = <String, RouteFactory>{
  'two_argument_page': (RouteSettings settings) => MaterialPageRoute(
        builder: (BuildContext context) => TwoArgumentPage(
          title: (settings.arguments as Map<String, dynamic>)['title'],
          subTitle: (settings.arguments as Map<String, dynamic>)['subTitle'],
        ),
      ),
};
