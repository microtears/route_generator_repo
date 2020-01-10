const contentTemplate = "#@";

const importTemplate = "import 'package:$contentTemplate'";

const routeNameTemplate = '$contentTemplate';

const onGenerateRouteItemTemplate = '...$contentTemplate.entries,';

const onGenerateRouteTemplate = '''
RouteFactory onGenerateRoute = (settings) => Map.fromEntries([
  $contentTemplate
])[settings.name](settings);
''';

const singleArgumentConstructorTemplate =
    "$contentTemplate($contentTemplate: $contentTemplate)";

const multiArgumentTemplate = "$contentTemplate: arguments['$contentTemplate']";

const multiArgumentConstructorTemplate = '''
{
  final arguments = settings.arguments as Map<String, dynamic>;
  return $contentTemplate(
    $contentTemplate
  );
},
''';

const defaultRouteMapTemplate = '''
Map<String, RouteFactory> $contentTemplate = <String, RouteFactory>{
  $contentTemplate
};
''';

const customRouteMapTemplate =
    'Map<String, RouteFactory> $contentTemplate = $contentTemplate.route;';

const routeMapItemTemplate =
    "$contentTemplate: (RouteSettings settings) => $contentTemplate";

const materialPageRouteTemplate = '''
MaterialPageRoute(
  builder: (BuildContext context) => $contentTemplate(),
)
''';

const pageBuilderTemplate =
    'pageBuilder: (context, animation, secondaryAnimation) =>$contentTemplate.$contentTemplate(context, animation, secondaryAnimation, settings)';
const transitionsBuilderTemplate =
    'transitionsBuilder: (context, animation, secondaryAnimation, child) =>$contentTemplate.$contentTemplate(context, animation, secondaryAnimation, child, settings)';
const transitionDurationTemplate =
    'transitionDuration: $contentTemplate.$contentTemplate';
const pageRouteBuilderTemplate = 'PageRouteBuilder($contentTemplate)';
