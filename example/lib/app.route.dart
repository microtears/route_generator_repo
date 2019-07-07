// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// RouteGenerator
// **************************************************************************

import 'package:flutter/material.dart';
import 'package:example/alias_name_page.dart';
import 'package:example/first_page.dart';
import 'package:example/custom_route_page.dart';
import 'package:example/arguement_page.dart';
import 'package:example/custom_name_page.dart';
import 'package:example/second_page.dart';

RouteFactory onGenerateRoute = (settings) => Map.fromEntries([
      ..._aliasNamePage.entries,
      ..._fun.entries,
      ..._home.entries,
      ...CustomRouteName.customRouteName.entries,
      ..._argumentPage.entries,
      ..._custom.entries,
      ..._secondPage.entries,
    ])[settings.name](settings);

Map<String, RouteFactory> _aliasNamePage = <String, RouteFactory>{
  'alias_name_page': (RouteSettings settings) =>
      MaterialPageRoute(builder: (BuildContext context) => AliasNamePage())
};
Map<String, RouteFactory> _fun = <String, RouteFactory>{
  'fun': (RouteSettings settings) =>
      MaterialPageRoute(builder: (BuildContext context) => AliasNamePage())
};
Map<String, RouteFactory> _home = <String, RouteFactory>{
  '/': (RouteSettings settings) =>
      MaterialPageRoute(builder: (BuildContext context) => FirstPage())
};
Map<String, RouteFactory> _argumentPage = <String, RouteFactory>{
  'argument_page': (RouteSettings settings) => MaterialPageRoute(
      builder: (BuildContext context) => ArgumentPage(
            (settings.arguments as Map<String, dynamic>)['title'],
            subTitle: (settings.arguments as Map<String, dynamic>)['subTitle'],
          ))
};
Map<String, RouteFactory> _custom = <String, RouteFactory>{
  'custom': (RouteSettings settings) =>
      MaterialPageRoute(builder: (BuildContext context) => NamedPage())
};
Map<String, RouteFactory> _secondPage = <String, RouteFactory>{
  'second_page': (RouteSettings settings) =>
      MaterialPageRoute(builder: (BuildContext context) => SecondPage())
};

const ROUTE_ALIAS_NAME_PAGE = 'alias_name_page';
const ROUTE_ALIAS_FUN = 'fun';
const ROUTE_FIRST_PAGE = '/';
const ROUTE_HOME = '/';
const ROUTE_ARGUMENT_PAGE = 'argument_page';
const ROUTE_CUSTOM = 'custom';
const ROUTE_SECOND_PAGE = 'second_page';
