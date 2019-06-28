import 'package:build/build.dart';
import 'package:route_generator/src/route_collector.dart';
import 'package:route_generator/src/route_generator.dart';
import 'package:source_gen/source_gen.dart';

Builder routeBuilder(BuilderOptions options) => LibraryBuilder(RouteGenerator(), generatedExtension: ".route.dart");
Builder routeCollector(BuilderOptions options) => LibraryBuilder(RouteCollector(), generatedExtension: ".collector.dart");
