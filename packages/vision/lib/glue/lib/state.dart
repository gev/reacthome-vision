import 'package:glue/module.dart';
import 'package:vision/glue/lib/state/listen.dart';
import 'package:vision/glue/lib/state/modify.dart';
import 'package:vision/glue/lib/state/read.dart';
import 'package:vision/glue/lib/state/state.dart';
import 'package:vision/glue/lib/state/write.dart';
import 'package:vision/logger.dart';

/// State module providing reactive state management and UI components
ModuleInfo stateModule(Logger log) => nativeModule('ffi.vision.state', [
  ('state', state),
  ('listen', listen(log)),
  ('read', read),
  ('write', write),
  ('modify', modify),
]);
