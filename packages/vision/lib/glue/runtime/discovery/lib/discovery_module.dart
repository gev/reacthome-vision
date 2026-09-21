import 'package:glue/module.dart';
import 'package:vision/glue/runtime/discovery/lib/discovery.dart';

ModuleInfo discoveryModule = nativeModule('ffi.discovery.applets', [
  ('discovery', discovery),
]);
