import 'package:glue/module.dart';
import 'package:vision/glue/lib/store/lookup.dart';
import 'package:vision/glue/lib/store/put.dart';
import 'package:vision/glue/lib/store/store.dart';
import 'package:vision/pub_sub/subscriber.dart';

/// Generic store module providing key-value storage
ModuleInfo storeModule(Subscriber<String> subscriber) {
  return nativeModule('ffi.vision.store', [
    ('put', put),
    ('lookup', lookup),
    ('store', store(subscriber)),
  ]);
}
