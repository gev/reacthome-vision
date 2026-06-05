import 'package:glue/module.dart';
import 'package:vision/glue/lib/module/import.dart';
import 'package:vision/glue/lib/module/module.dart';
import 'package:vision/glue/pub_sub/glue_subscriber.dart';

/// Generic store module providing key-value storage
ModuleInfo storeModule(GlueSubscriber subscriber) {
  return nativeModule('ffi.vision.module', [
    ('import', import),
    ('module', module(subscriber)),
  ]);
}
