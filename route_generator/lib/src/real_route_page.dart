import 'real_route_paramemter.dart';
import 'string_case.dart';
import 'util.dart';

class RealRoutePage {
  String import;
  String name;
  String className;
  bool isInitialRoute;
  List<RealRouteParameter> params;

  RealRoutePage(
    this.import,
    this.className,
    this.name, {
    this.isInitialRoute = false,
    this.params = const [],
  });

  @override
  String toString() {
    return "$runtimeType(import: $import,name: $name,"
        "className: $className,isInitialRoute: $isInitialRoute,"
        "params: ${params.join(",")})";
  }

  String get routeVariableName => normalizeName(name);

  String get routeConstantName => format(
      routeVariableName, CaseFormat.LOWER_CAMEL, CaseFormat.UPPER_UNDERSCORE);

  String get routeName => isInitialRoute
      ? "/"
      : format(routeVariableName, CaseFormat.LOWER_CAMEL,
          CaseFormat.LOWER_UNDERSCORE);

  String buildRouteName() => "const ROUTE_$routeConstantName = '$routeName';";

  String buildRouteEntries() => '''
  ROUTE_$routeConstantName: (RouteSettings settings) => MaterialPageRoute(
    builder: (BuildContext context) {${params.length > 1 ? "final arguments = settings.arguments as Map<String, dynamic>;\n" : ""}
      return $className(${_buildParameters()});
    },
  ),   
''';

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
}
