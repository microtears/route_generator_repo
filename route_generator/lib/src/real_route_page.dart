import 'real_route_paramemter.dart';
import 'util.dart';

class RealRoutePage extends Object {
  String import;
  String name;
  String className;
  bool isInitialRoute;
  List<RealRouteParameter> params;
  String routeField;
  String pageRouteBuilderFunction;
  String routePageBuilderFunction;
  String routeTransitionBuilderFunction;
  String routeTransitionDurationField;

  RealRoutePage(
    this.import,
    this.className,
    this.name, {
    this.isInitialRoute = false,
    this.params = const [],
    this.routeField,
    this.pageRouteBuilderFunction,
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
    if (pageRouteBuilderFunction != null) {
      return "Map<String, RouteFactory> _$routeVariableName = "
          "<String, RouteFactory>{'$routeName': $className.$pageRouteBuilderFunction,};";
    }
    final param = _buildParameters();
    if (routePageBuilderFunction == null &&
        routeTransitionBuilderFunction == null &&
        routeTransitionDurationField == null) {
      if (params.length < 2) {
        return "Map<String, RouteFactory> _$routeVariableName = "
            "<String, RouteFactory>{'$routeName': (RouteSettings settings) => "
            "MaterialPageRoute(builder: (BuildContext context) => $className($param),),};";
      } else {
        return "Map<String, RouteFactory> _$routeVariableName = "
            "<String, RouteFactory>{'$routeName': (RouteSettings settings) => "
            "MaterialPageRoute(builder: (BuildContext context) {"
            "final arguments = settings.arguments as Map<String, dynamic>;"
            "return $className($param);},),};";
      }
    }
    final page = routePageBuilderFunction == null
        ? "pageBuilder: (context,animation,secondaryAnimation) => $className($param),"
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

  String _buildParameters() {
    if (params.isEmpty) {
      return "";
    } else if (params.length == 1) {
      return "${params[0].name} : settings.arguments";
    } else {
      final buffer = StringBuffer();
      params.forEach((param) {
        final key = param.key ?? param.name;
        buffer.write("${param.name} : arguments['$key'],");
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
