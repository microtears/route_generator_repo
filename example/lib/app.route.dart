// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// RouteGenerator
// **************************************************************************

import 'package:flutter/material.dart';
import 'second/second_page.dart';
import 'third_page.dart';
import 'first_page.dart';

RouteFactory onGenerateRoute = (settings) => Map.fromEntries([
      ..._secondPage.entries,
      ..._customRoute.entries,
      ..._home.entries,
    ])[settings.name](settings);

Map<String, RouteFactory> _secondPage = <String, RouteFactory>{
  'second_page': (settings) =>
      MaterialPageRoute(builder: (BuildContext context) => SecondPage())
};
Map<String, RouteFactory> _customRoute = <String, RouteFactory>{
  'custom_route': (settings) =>
      MaterialPageRoute(builder: (BuildContext context) => ThirdPage())
};
Map<String, RouteFactory> _home = <String, RouteFactory>{
  'home': (settings) =>
      MaterialPageRoute(builder: (BuildContext context) => FirstPage())
};

const ROUTE_SECOND_PAGE = 'second_page';
const ROUTE_CUSTOM_ROUTE = 'custom_route';
const ROUTE_HOME = 'home';
