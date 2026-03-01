import 'package:glue/module.dart';
import 'package:vision/glue/lib/store/lookup_function.dart';
import 'package:vision/glue/lib/store/put_function.dart';
import 'package:vision/glue/lib/store/store_object.dart';

/// Generic store module providing key-value storage
ModuleInfo storeModule(Sink<String> sink) {
  return nativeModule('ffi.vision.store', [
    ('put', putFunction),
    ('lookup', lookupFunction),
    ('store', storeObject(sink)),
  ]);
}
