import 'package:glue/module.dart';
import 'package:vision/glue/lib/state/listen.dart';
import 'package:vision/glue/lib/state/local_state.dart';
import 'package:vision/glue/lib/state/modify.dart';
import 'package:vision/glue/lib/state/persistent_local_state.dart';
import 'package:vision/glue/lib/state/read.dart';
import 'package:vision/glue/lib/state/write.dart';
import 'package:vision/logger.dart';
import 'package:vision/mode/live/glue/lib/state/persistent_remote_state.dart';

/// State module providing reactive state management
ModuleInfo liveStateModule(Logger log) => nativeModule('ffi.vision.state', [
  ('local-state', localState),
  ('persistent-local-state', persistentLocalState),
  ('remote-state', localState),
  ('persistent-remote-state', persistentRemoteState),
  ('listen', listen(log)),
  ('read', read),
  ('write', write),
  ('modify', modify),
]);
