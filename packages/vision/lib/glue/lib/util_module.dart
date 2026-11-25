import 'package:glue/module.dart';
import 'package:vision/glue/lib/util/hash.dart';

final ModuleInfo utilModule = nativeModule('ffi.vision.util', [
  ('hash', hashString),
]);
