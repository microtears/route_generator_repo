import 'real_route_paramemter.dart';
import 'util.dart';

class RealRoutePage extends Object {
  String import;
  String name;
  String className;
  bool isInitialRoute;
  List<RealRouteParameter> prarms;
  String routeField;
  String pageRouteBuilderFuntcion;
  String routePageBuilderFunction;
  String routeTransitionBuilderFunction;
  String routeTransitionDurationField;

  RealRoutePage(
    this.import,
    this.className,
    this.name, {
    this.isInitialRoute = false,
    this.prarms = const [],
    this.routeField,
    this.pageRouteBuilderFuntcion,
    this.routePageBuilderFunction,
    this.routeTransitionBuilderFunction,
    this.routeTransitionDurationField,
  });

  String get routeVariableName => normalizeName(name);
  String get routeConstantName => formatLC2UU(routeVariableName);
  String get routeName => isInitialRoute ? "/" : formatLC2LU(routeVariableName);

  String buildRoute() {
    if (routeField != null) {
      return "Map<String, RouteFactory> _$routeVariableName = $className.$routeField;";
    }
    if (pageRouteBuilderFuntcion != null) {
      return "Map<String, RouteFactory> _$routeVariableName = "
          "<String, RouteFactory>{'$routeName': $className.$pageRouteBuilderFuntcion,};";
    }
    final prarm = _buildPrarmters();
    if (routePageBuilderFunction == null &&
        routeTransitionBuilderFunction == null &&
        routeTransitionDurationField == null) {
      if (prarms.length < 2) {
        return "Map<String, RouteFactory> _$routeVariableName = "
            "<String, RouteFactory>{'$routeName': (RouteSettings settings) => "
            "MaterialPageRoute(builder: (BuildContext context) => $className($prarm),),};";
      } else {
        return "Map<String, RouteFactory> _$routeVariableName = "
            "<String, RouteFactory>{'$routeName': (RouteSettings settings) => "
            "MaterialPageRoute(builder: (BuildContext context) {"
            "final arguments = settings.arguments as Map<String, dynamic>;"
            "return $className($prarm);},),};";
      }
    }
    final page = routePageBuilderFunction == null
        ? "pageBuilder: (context,animation,secondaryAnimation) => $className($prarm),"
        : "pageBuilder: (context,animation,secondaryAnimation) => "
            "$className.$routePageBuilderFunction(context,animation,secondaryAnimation,settings),";
    final transitions = routeTransitionBuilderFunction == null
        ? ""
        : "transitionsBuilder: (context,animation,secondaryAnimation,child) => "
            "$className.$routeTransitionBuilderFunction(context,animation,secondaryAnimation,child,settings),";
    final duration = routeTransitionDurationField == null
        ? ""
        : "transitionDuration: $className.$routeTransitionDurationField,";
    return "Map<String, RouteFactory> _$routeVariableName = "
        "<String, RouteFactory>{'$routeName': (RouteSettings settings) => "
        "PageRouteBuilder($page$transitions$duration),};";
  }

  String buildRouteName() => "const ROUTE_$routeConstantName = '$routeName';";

  String buildRouteEntries() => "..._$routeVariableName.entries,";

  String _buildPrarmters() {
    if (prarms.isEmpty) {
      return "";
    } else if (prarms.length == 1) {
      return "${prarms[0].name} : settings.arguments";
    } else {
      final buffer = StringBuffer();
      prarms.forEach((prarm) {
        final key = prarm.key ?? prarm.name;
        buffer.write("${prarm.name} : arguments['$key'],");
      });
      return buffer.toString();
    }
  }

  @override
  bool operator ==(other) =>
      other is RealRoutePage && routeName == other.routeName;

  @override
  int get hashCode => routeName.hashCode;
}
