class RouteParameter {
  /// [key] If you pass multiple parameters at a time, you must provide
  ///  a Map Key to take the parameters from [RouteSettings.arguments],
  /// and when you use [Navigator] to switch routes, the parameters must
  /// be passed as a Map. If the value is `null`, the default is [name]
  /// as the key. If there is only one parameter, when switching routes
  /// using [Navigator], the parameters can be passed directly instead
  /// of being passed as a Map.
  final String key;

  /// [name] optional parameter name
  final String name;

  /// An annotation used to mark page parameters is only designed for
  /// optional parameters. Used for [RoutePage].
  ///
  /// * [name] optional parameter name
  /// * [key] If you pass multiple parameters at a time, you must provide
  ///  a Map Key to take the parameters from [RouteSettings.arguments],
  /// and when you use [Navigator] to switch routes, the parameters must
  /// be passed as a Map. If the value is `null`, the default is [name]
  /// as the key. If there is only one parameter, when switching routes
  /// using [Navigator], the parameters can be passed directly instead
  /// of being passed as a Map.
  ///
  /// example:
  /// ```dart
  /// @RoutePage(prarms: [RouteParameter("title")])
  /// class OneArgumentPage extends StatelessWidget {
  ///   final String title;
  ///
  ///   const OneArgumentPage({Key key, this.title}) : super(key: key);
  ///
  ///   @override
  ///   Widget build(BuildContext context) {
  ///     return Container();
  ///   }
  /// }
  ///
  ///
  /// @RoutePage(prarms: [RouteParameter("title"), RouteParameter("subTitle")])
  /// class TwoArgumentPage extends StatelessWidget {
  ///   final String title;
  ///   final String subTitle;
  ///
  ///   TwoArgumentPage({this.title, Key key, this.subTitle}) : super(key: key);
  ///
  ///   @override
  ///   Widget build(BuildContext context) {
  ///     return Scaffold(
  ///       body: SafeArea(
  ///         child: Padding(
  ///           padding: const EdgeInsets.all(16.0),
  ///           child: Column(
  ///             crossAxisAlignment: CrossAxisAlignment.start,
  ///             children: <Widget>[
  ///               Text(
  ///                 title,
  ///                 style: TextStyle(fontSize: 60, fontWeight: FontWeight.bold),
  ///               ),
  ///               Text(
  ///                 subTitle,
  ///                 style: TextStyle(fontSize: 40),
  ///               ),
  ///             ],
  ///           ),
  ///         ),
  ///       ),
  ///     );
  ///   }
  /// }
  /// ```
  const RouteParameter(this.name, {this.key}) : assert(name != null);
}
