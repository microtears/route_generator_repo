/// 一个用来标志页面参数的注解，只为可选参数设计。用于[RoutePage]。
///
/// * [name] 可选参数名称
/// * [key] 如果一次传递多个参数，则必须提供Map Key，以便从[RouteSettings.arguments]中取出参数,
/// 同时，在使用[Navigator]切换路由时，参数必须作为Map传递。如果值为`null`,则默认以[name]作为key。
/// 如果只有一个参数，则在使用[Navigator]切换路由时，参数可以直接传递，而不是作为Map传递。
///
/// 例如：
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
class RouteParameter {
  final String key;
  final String name;

  const RouteParameter(this.name, {this.key}) : assert(name != null);
}
