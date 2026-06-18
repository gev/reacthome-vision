import 'dart:io';

import 'package:glue/module.dart';
import 'package:vision/glue/lib/store/lookup.dart';
import 'package:vision/glue/lib/store/put.dart';
import 'package:vision/glue/lib/store/store.dart';
import 'package:vision/glue/logger.dart';
import 'package:vision/glue/pub_sub/glue_subscriber.dart';
import 'package:vision/glue/stores/persistent_store.dart';
import 'package:vision/glue/stores/tmp_store.dart';

/// Generic store module providing key-value storage
ModuleInfo storeModule(
  Directory path,
  GlueSubscriber subscriber,
  TmpStore tmpStore,
  DataStore dataStore,
  Logger log,
) {
  return nativeModule('ffi.vision.store', [
    ('put', put(subscriber)),
    ('lookup', lookup),
    ('store', store(path, subscriber, tmpStore, dataStore, log)),
  ]);
}
