import 'package:glue/module.dart';
import 'package:vision/glue/lib/widgets/placeholder.dart';
import 'package:vision/glue/lib/widgets/screen.dart';

/// State module providing reactive state management and UI components
final widgetsModule = nativeModule('ffi.vision.widgets', [
  ('placeholder', placeholder),
  ('screen', screen),
]);
