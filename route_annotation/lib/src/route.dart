/// 此注解用来标志某个为Flutter App的类，并以此生成相应的路由代码
///
/// 例如：
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
class Router {
  const Router();
}
