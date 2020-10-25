import 'route_parameter.dart';

class Route {
  /// [name] The name of the route. It is recommended to use an
  /// underscore name, such as `custom_route_name`, or a url
  /// path separated by `/`, for example: `/library/music`.
  final String name;

  /// [isInitialRoute] Is the initialization route page, if
  /// the value is `true`, the custom route name [name] will
  /// be ignored and a route constant named `ROUTE_HOME`
  /// will be generated.
  final bool isInitialRoute;

  /// [params] For the routing parameter list, refer to
  /// [RouteParam] for details.
  final List<RouteParam> params;

  /// This annotation is used to annotate a routing page
  ///
  /// * [name] The name of the route. It is recommended to use an
  /// underscore name, such as `custom_route_name`, or a url
  /// path separated by `/`, for example: `/library/music`.
  /// * [isInitialRoute] Is the initialization route page, if
  /// the value is `true`, the custom route name [name] will
  /// be ignored and a route constant named `ROUTE_HOME`
  /// will be generated.
  /// * [params] For the routing parameter list, refer to
  /// [RouteParam] for details.
  ///
  /// example:
  /// ```dart
  /// @RoutePage(isInitialRoute: true)
  /// class HomePage extends StatelessWidget {
  ///   @override
  ///   Widget build(BuildContext context) {
  ///     return Scaffold(body: Center(child: Text("Home Page")));
  ///   }
  /// }
  ///```
  const Route({
    this.name,
    this.isInitialRoute = false,
    this.params = const [],
  });
}
