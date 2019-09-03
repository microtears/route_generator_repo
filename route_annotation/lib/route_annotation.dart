library route_annotation;

export 'src/route.dart';
export 'src/route_page.dart';
export 'src/route_parameter.dart';
export 'src/route_getter.dart';
export 'src/page_route_builder_function.dart';
export 'src/route_page_builder_function.dart';
export 'src/route_transitions_builder_function.dart';
export 'src/transition_duration_getter.dart';

import 'src/route.dart';
import 'src/route_page.dart';
import 'src/route_getter.dart';
import 'src/page_route_builder_function.dart';
import 'src/route_page_builder_function.dart';
import 'src/route_transitions_builder_function.dart';
import 'src/transition_duration_getter.dart';

const router = Router();

const page = RoutePage();

const initialPage = RoutePage(isInitialRoute: true);

const routeField = RouteField();

const routeBuilder = PageRouteBuilderFuntcion();

const pageBuilder = RoutePageBuilderFunction();

const transitionBuilder = RouteTransitionBuilderFunction();

const transitionDuration = RouteTransitionDurationField();
