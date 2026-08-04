import 'package:glue/module.dart';
import 'package:vision/glue/lib/state/local_state.dart';
import 'package:vision/glue/lib/state/modify.dart';
import 'package:vision/glue/lib/state/react.dart';
import 'package:vision/glue/lib/state/read.dart';
import 'package:vision/glue/lib/state/render.dart';
import 'package:vision/glue/lib/state/write.dart';
import 'package:vision/glue/lib/store/lookup.dart';
import 'package:vision/glue/reactive_runtime.dart';
import 'package:vision/logger.dart';
import 'package:vision/mode/live/live_storage.dart';

/// State module providing reactive state management
ModuleInfo liveStateModule(
  ReactiveRuntime reactiveRuntime,
  LiveStorage storage,
  Logger log,
) => nativeModule('ffi.vision.state', [
  ('local-state', localState),
  (
    'local-persistent-state',
    lookupReadWrite(
      lookup: storage.localPersistentStore,
      put: storage.localPersistentStore,
    ),
  ),
  ('remote-state', lookupReadOnly(lookup: storage.remoteStore)),
  (
    'remote-persistent-state',
    lookupReadOnly(lookup: storage.remotePersistentStore),
  ),
  ('react', react(reactiveRuntime: reactiveRuntime, log: log)),
  ('render', render),
  ('read', read),
  ('write', write),
  ('modify', modify),
]);
