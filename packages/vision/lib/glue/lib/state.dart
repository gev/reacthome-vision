import 'package:glue/module.dart';
import 'package:vision/glue/lib/state/listen.dart';
import 'package:vision/glue/lib/state/local_state.dart';
import 'package:vision/glue/lib/state/modify.dart';
import 'package:vision/glue/lib/state/read.dart';
import 'package:vision/glue/lib/state/write.dart';
import 'package:vision/glue/lib/store/lookup.dart';
import 'package:vision/glue/stores/glue_reactive_db.dart';
import 'package:vision/logger.dart';
import 'package:vision/mode/local/local_storage.dart';

/// State module providing reactive state management
ModuleInfo localStateModule(LocalStorage storage, Logger log) =>
    nativeModule('ffi.vision.state', [
      ('local-state', localState),
      // ('persistent-local-state', lookup(storage.localStore)),
      ('listen', listen(log)),
      ('read', read),
      ('write', write),
      ('modify', modify),
    ]);
