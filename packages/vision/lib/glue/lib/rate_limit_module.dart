import 'package:glue/module.dart';
import 'package:vision/glue/lib/rate_limit/debounce.dart';
import 'package:vision/glue/lib/rate_limit/throttle.dart';
import 'package:vision/logger.dart';

ModuleInfo rateLimitModule(Logger log) => nativeModule(
  'ffi.vision.rate-limit',
  [('debounce', debounce(log)), ('throttle', throttle(log))],
);
