import 'package:glue/module.dart';
import 'package:vision/glue/lib/routes/overlay_route.dart';
import 'package:vision/glue/lib/routes/route.dart';

/// Navigation module providing navigation functions
final routesModule = nativeModule('ffi.vision.routes', [
  ('route', route),
  ('overlay-route', overlayRoute),
]);
