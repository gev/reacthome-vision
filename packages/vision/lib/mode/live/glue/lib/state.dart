import 'package:glue/module.dart';
import 'package:vision/glue/lib/state/listen.dart';
import 'package:vision/glue/lib/state/local_state.dart';
import 'package:vision/glue/lib/state/modify.dart';
import 'package:vision/glue/lib/state/read.dart';
import 'package:vision/glue/lib/state/write.dart';
import 'package:vision/glue/lib/store/lookup.dart';
import 'package:vision/logger.dart';
import 'package:vision/mode/live/live_storage.dart';

/// State module providing reactive state management
ModuleInfo liveStateModule(LiveStorage storage, Logger log) =>
    nativeModule('ffi.vision.state', [
      ('local-state', localState),
      // ('persistent-local-state', lookup(storage.localStore)),
      ('remote-state', lookup(storage.remoteStore)),
      ('persistent-remote-state', lookup(storage.remotePersistentStore)),
      ('listen', listen(log)),
      ('read', read),
      ('write', write),
      ('modify', modify),
    ]);
