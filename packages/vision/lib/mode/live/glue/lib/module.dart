import 'package:glue/module.dart';
import 'package:vision/glue/pub_sub/glue_subscriber.dart';
import 'package:vision/mode/live/glue/lib/module/import.dart';
import 'package:vision/mode/live/glue/live_reactive_runtime.dart';

/// Generic module module providing module storage
ModuleInfo moduleModule(
  GlueSubscriber subscriber,
  LiveReactiveRuntime runtime,
) {
  return nativeModule('ffi.vision.module', [
    ('import', import(subscriber, runtime)),
  ]);
}
