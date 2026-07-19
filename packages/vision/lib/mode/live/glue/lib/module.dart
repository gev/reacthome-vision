import 'package:glue/module.dart';
import 'package:vision/glue/pub_sub/glue_subscriber.dart';
import 'package:vision/glue/reactive_runtime.dart';
import 'package:vision/mode/live/glue/lib/module/import.dart';

/// Generic module module providing module storage
ModuleInfo moduleModule(GlueSubscriber subscriber, ReactiveRuntime runtime) {
  return nativeModule('ffi.vision.module', [
    ('import', import(subscriber, runtime)),
  ]);
}
