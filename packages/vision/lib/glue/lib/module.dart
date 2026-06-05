import 'package:glue/module.dart';
import 'package:vision/glue/lib/module/import.dart';
import 'package:vision/glue/lib/module/module.dart';
import 'package:vision/glue/pub_sub/glue_subscriber.dart';

/// Generic module module providing module storage
ModuleInfo moduleModule(ModuleSubscriber subscriber) {
  return nativeModule('ffi.vision.module', [
    ('import', import(subscriber)),
    ('module', module(subscriber)),
  ]);
}
