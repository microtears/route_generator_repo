// GENERATED CODE - DO NOT MODIFY BY HAND

import 'package:flutter/material.dart';
import 'package:example/pages/custom_route_name_page.dart';
import 'package:example/pages/home_page.dart';
import 'package:example/pages/one_arguement_page.dart';
import 'package:example/pages/second_page.dart';
import 'package:example/pages/two_arguement_page.dart';

const ROUTE_CUSTOM = 'custom';
const ROUTE_HOME = '/';
const ROUTE_ONE_ARGUMENT_PAGE = 'one_argument_page';
const ROUTE_SECOND_PAGE = 'second_page';
const ROUTE_TWO_ARGUMENT_PAGE = 'two_argument_page';

final RouteFactory onGenerateRoute = (settings) => <String, RouteFactory>{
  ROUTE_CUSTOM: (RouteSettings settings) => MaterialPageRoute(
    builder: (BuildContext context) {
      return CustomRoutePageName();
    },
  ),   
  ROUTE_HOME: (RouteSettings settings) => MaterialPageRoute(
    builder: (BuildContext context) {
      return HomePage();
    },
  ),   
  ROUTE_ONE_ARGUMENT_PAGE: (RouteSettings settings) => MaterialPageRoute(
    builder: (BuildContext context) {
      return OneArgumentPage(title : settings.arguments);
    },
  ),   
  ROUTE_SECOND_PAGE: (RouteSettings settings) => MaterialPageRoute(
    builder: (BuildContext context) {
      return SecondPage();
    },
  ),   
  ROUTE_TWO_ARGUMENT_PAGE: (RouteSettings settings) => MaterialPageRoute(
    builder: (BuildContext context) {
      final arguments = settings.arguments as Map<String, dynamic>;
      return TwoArgumentPage(title : arguments['title'],subTitle : arguments['subTitle'],);
    },
  ),   

}[settings.name](settings);

