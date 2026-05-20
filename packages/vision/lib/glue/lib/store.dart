import 'package:glue/module.dart';
import 'package:vision/glue/lib/store/lookup.dart';
import 'package:vision/glue/lib/store/put.dart';
import 'package:vision/glue/lib/store/store.dart';

/// Generic store module providing key-value storage
ModuleInfo storeModule(Sink<String> sink) {
  return nativeModule('ffi.vision.store', [
    ('put', put),
    ('lookup', lookup),
    ('store', store(sink)),
  ]);
}
