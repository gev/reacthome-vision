import 'package:glue/module.dart';
import 'package:vision/glue/lib/state/listen_function.dart';
import 'package:vision/glue/lib/state/modify_function.dart';
import 'package:vision/glue/lib/state/read_function.dart';
import 'package:vision/glue/lib/state/state_function.dart';
import 'package:vision/glue/lib/state/write_function.dart';

/// State module providing reactive state management and UI components
final stateModule = nativeModule('ffi.ui.state', [
  ('state', stateFunction),
  ('listen', listenFunction),
  ('read', readFunction),
  ('write', writeFunction),
  ('modify', modifyFunction),
]);
