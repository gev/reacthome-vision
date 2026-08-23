import 'package:glue/module.dart';
import 'package:vision/glue/lib/reate_limit/debounce.dart';
import 'package:vision/glue/lib/reate_limit/throttle.dart';
import 'package:vision/logger.dart';

ModuleInfo rateLimitModule(Logger log) => nativeModule('ffi.vision.rpc', [
  ('debounce', debounce(log)),
  ('throttle', throttle(log)),
]);
