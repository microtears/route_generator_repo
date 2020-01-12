library route_annotation;

export 'src/route.dart';
export 'src/route_page.dart';
export 'src/route_parameter.dart';
export 'src/interceptor.dart';

import 'src/route.dart';
import 'src/route_page.dart';
import 'src/interceptor.dart';

const router = Router();

const page = RoutePage();

const initialPage = RoutePage(isInitialRoute: true);

const interceptor = Interceptor();
