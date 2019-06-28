import 'package:flutter/material.dart';

String routeName(Map<String, RouteFactory> route, {String alias}) => alias == null ? route.keys.first : route[alias];
