// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// RouteGenerator
// **************************************************************************

import 'package:flutter/material.dart';
import 'first_page.dart';
import 'third_page.dart';
import 'second/second_page.dart';

RouteFactory onGenerateRoute = (settings) => Map.fromEntries([
      ..._home.entries,
      ..._customRoute.entries,
      ..._secondPage.entries,
    ])[settings.name](settings);

Map<String, RouteFactory> _home = <String, RouteFactory>{
  '/': (RouteSettings settings) =>
      MaterialPageRoute(builder: (BuildContext context) => FirstPage())
};
Map<String, RouteFactory> _customRoute = <String, RouteFactory>{
  'custom_route': (RouteSettings settings) => MaterialPageRoute(
      builder: (BuildContext context) => ThirdPage(
            settings.arguments ?? 'defaultValue',
            secondValue:
                (settings.arguments as Map<String, dynamic>)['secondKey'],
          ))
};
Map<String, RouteFactory> _secondPage = <String, RouteFactory>{
  'second_page': (RouteSettings settings) =>
      MaterialPageRoute(builder: (BuildContext context) => SecondPage())
};

const ROUTE_HOME = '/';
const ROUTE_CUSTOM_ROUTE = 'custom_route';
const ROUTE_SECOND_PAGE = 'second_page';
