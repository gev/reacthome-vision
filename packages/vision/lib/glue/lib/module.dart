import 'package:glue/module.dart';
import 'package:vision/glue/lib/module/import.dart';
import 'package:vision/glue/pub_sub/glue_subscriber.dart';
import 'package:vision/glue/stores/reactive_runtime.dart';

/// Generic module module providing module storage
ModuleInfo moduleModule(GlueSubscriber subscriber, ReactiveRuntime runtime) {
  return nativeModule('ffi.vision.module', [
    ('import', import(subscriber, runtime)),
  ]);
}
