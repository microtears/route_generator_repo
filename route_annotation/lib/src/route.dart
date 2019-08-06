class Router {
  /// This annotation is used to mark a class that is a Flutter App
  /// and use this to generate the corresponding routing code.
  ///
  /// example:
  /// ```dart
  /// @Router()
  /// class DemoApp extends StatefulWidget {
  ///   @override
  ///   _DemoAppState createState() => _DemoAppState();
  /// }
  ///
  /// class _DemoAppState extends State<DemoApp> {
  ///   @override
  ///   Widget build(BuildContext context) {
  ///     return MaterialApp(
  ///       initialRoute: "/",
  ///       onGenerateRoute: onGenerateRoute,
  ///     );
  ///   }
  /// }
  /// ```
  const Router();
}
