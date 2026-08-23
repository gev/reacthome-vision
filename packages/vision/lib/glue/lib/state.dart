import 'package:glue/module.dart';
import 'package:vision/glue/lib/state/listen.dart';
import 'package:vision/glue/lib/state/local_state.dart';
import 'package:vision/glue/lib/state/modify.dart';
import 'package:vision/glue/lib/state/optimistic_state.dart';
import 'package:vision/glue/lib/state/read.dart';
import 'package:vision/glue/lib/state/write.dart';
import 'package:vision/glue/lib/store/lookup.dart';
import 'package:vision/mode/local/local_storage.dart';

/// State module providing reactive state management
ModuleInfo localStateModule(LocalStorage storage) =>
    nativeModule('ffi.vision.state', [
      ('local-state', localState),
      ('optimistic-state', optimisticState),
      (
        'local-persistent-state',
        lookupReadWrite(
          lookup: storage.localPersistentStore,
          put: storage.localPersistentStore,
        ),
      ),
      ('listen', listen),
      ('read', read),
      ('write', write),
      ('modify', modify),
    ]);
