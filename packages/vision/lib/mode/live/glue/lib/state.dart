import 'package:glue/module.dart';
import 'package:vision/glue/lib/state/listen.dart';
import 'package:vision/glue/lib/state/local_state.dart';
import 'package:vision/glue/lib/state/modify.dart';
import 'package:vision/glue/lib/state/read.dart';
import 'package:vision/glue/lib/state/write.dart';
import 'package:vision/glue/lib/store/lookup.dart';
import 'package:vision/mode/live/live_storage.dart';

/// State module providing reactive state management
ModuleInfo liveStateModule(LiveStorage storage) =>
    nativeModule('ffi.vision.state', [
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
      ('render', listen),
      ('read', read),
      ('write', write),
      ('modify', modify),
    ]);
