library route_annotation;

import 'src/app_route.dart';
import 'src/interceptor.dart';
import 'src/route.dart';

export 'src/app_route.dart';
export 'src/interceptor.dart';
export 'src/route.dart';
export 'src/route_parameter.dart';

const appRouter = AppRouter();

const route = Route();

const initialRoute = Route(isInitialRoute: true);

const interceptor = Interceptor();
