import 'package:glue/module.dart';
import 'package:vision/glue/lib/widgets/placeholder.dart';

/// State module providing reactive state management and UI components
final widgetsModule = nativeModule('ffi.vision.navigation', [
  ('route', routeFunction),
  ('push', pushFunction),
  ('push-replacement', pushReplacementFunction),
  ('pop', popFunction),
  ('can-pop', canPopFunction),
]);
