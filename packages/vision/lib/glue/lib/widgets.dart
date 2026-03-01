import 'package:glue/module.dart';
import 'package:vision/glue/lib/widgets/placeholder.dart';

/// State module providing reactive state management and UI components
final widgetsModule = nativeModule('ffi.vision.widgets', [
  ('placeholder', placeholder),
]);
