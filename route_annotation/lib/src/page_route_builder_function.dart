class PageRouteBuilderFuntcion {
  /// This annotation is used to identify the [RouteFactory]
  /// static method of a routing page.
  ///
  /// example:
  /// ```dart
  ///  @PageRouteBuilderFuntcion()
  ///  static Route buildPageRoute(RouteSettings settings) => PageRouteBuilder(
  ///        pageBuilder: (BuildContext context, Animation animation,
  ///                Animation secondaryAnimation) =>
  ///            CustomRoutePage(),
  ///      );
  /// ```
  const PageRouteBuilderFuntcion();
}
