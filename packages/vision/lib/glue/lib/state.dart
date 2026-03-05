import 'package:glue/module.dart';
import 'package:vision/glue/lib/state/listen.dart';
import 'package:vision/glue/lib/state/modify.dart';
import 'package:vision/glue/lib/state/read.dart';
import 'package:vision/glue/lib/state/state.dart';
import 'package:vision/glue/lib/state/write.dart';

/// State module providing reactive state management and UI components
final stateModule = nativeModule('ffi.vision.state', [
  ('state', state),
  ('listen', listen),
  ('read', read),
  ('write', write),
  ('modify', modify),
]);
