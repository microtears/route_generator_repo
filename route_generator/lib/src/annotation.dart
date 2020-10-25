import 'package:route_annotation/route_annotation.dart';

import 'string_case.dart';
import 'util.dart';

class ActualRouteParam extends RouteParam {
  ActualRouteParam(String name, {String key}) : super(name, key: key);
}

class ActualRoute extends Route implements Comparable<ActualRoute> {
  String import;
  String className;

  ActualRoute(
    this.import,
    this.className,
    String name, {
    bool isInitialRoute = false,
    List<ActualRouteParam> params = const [],
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

  String get routeNameStatement =>
      "const ROUTE_$routeConstantName = '$routeName';";

  String get routeStatement => "const ROUTE_$routeConstantName = '$routeName';";

  String buildRouteEntries() => '''
  ROUTE_$routeConstantName: (RouteSettings settings) => MaterialPageRoute(
    builder: (BuildContext context) {${params.length > 1 ? "\n      final arguments = settings.arguments as Map<String, dynamic>;" : ""}
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

  @override
  int compareTo(ActualRoute other) {
    return name.compareTo(other.name);
  }
}
