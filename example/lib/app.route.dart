// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// RouteGenerator
// **************************************************************************

import 'package:flutter/material.dart';
import 'custom_route_name_page.dart';
import 'alias_name_page.dart';
import 'arguement_page.dart';
import 'custom_route_page.dart';
import 'second_page.dart';
import 'first_page.dart';

RouteFactory onGenerateRoute = (settings) => Map.fromEntries([
      ..._custom.entries,
      ..._aliasNamePage.entries,
      ..._fun.entries,
      ..._argumentPage.entries,
      ...CustomRouteName.route.entries,
      ..._secondPage.entries,
      ..._home.entries,
    ])[settings.name](settings);

Map<String, RouteFactory> _custom = <String, RouteFactory>{
  'custom': (RouteSettings settings) => MaterialPageRoute(
      builder: (BuildContext context) => CustomRouteNamePage())
};
Map<String, RouteFactory> _aliasNamePage = <String, RouteFactory>{
  'alias_name_page': (RouteSettings settings) =>
      MaterialPageRoute(builder: (BuildContext context) => AliasNamePage())
};
Map<String, RouteFactory> _fun = <String, RouteFactory>{
  'fun': (RouteSettings settings) =>
      MaterialPageRoute(builder: (BuildContext context) => AliasNamePage())
};
Map<String, RouteFactory> _argumentPage = <String, RouteFactory>{
  'argument_page': (RouteSettings settings) => MaterialPageRoute(
      builder: (BuildContext context) => ArgumentPage(
            (settings.arguments as Map<String, dynamic>)['title'],
            subTitle: (settings.arguments as Map<String, dynamic>)['subTitle'],
          ))
};
Map<String, RouteFactory> _secondPage = <String, RouteFactory>{
  'second_page': (RouteSettings settings) =>
      MaterialPageRoute(builder: (BuildContext context) => SecondPage())
};
Map<String, RouteFactory> _home = <String, RouteFactory>{
  '/': (RouteSettings settings) =>
      MaterialPageRoute(builder: (BuildContext context) => FirstPage())
};

const ROUTE_CUSTOM = 'custom';
const ROUTE_ALIAS_NAME_PAGE = 'alias_name_page';
const ROUTE_ALIAS_FUN = 'fun';
const ROUTE_ARGUMENT_PAGE = 'argument_page';
const ROUTE_SECOND_PAGE = 'second_page';
const ROUTE_FIRST_PAGE = '/';
const ROUTE_HOME = '/';
