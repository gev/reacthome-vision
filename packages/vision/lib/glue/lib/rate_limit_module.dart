import 'package:glue/module.dart';
import 'package:vision/glue/lib/rate_limit/debounce.dart';
import 'package:vision/glue/lib/rate_limit/throttle.dart';
import 'package:vision/logger.dart';

ModuleInfo rateLimitModule(Logger log) => nativeModule('ffi.rate-limit.rpc', [
  ('debounce', debounce(log)),
  ('throttle', throttle(log)),
]);
