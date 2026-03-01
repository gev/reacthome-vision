import 'package:glue/ir.dart';
import 'package:vision/glue/store/memory_cache.dart';
import 'package:vision/glue/store/memory_store.dart';

Ir storeObject(Sink<String> sink) {
  return IrObject({
    'memory': IrNativeValue(Value(memoryStore)),
    'cache': IrNativeValue(Value(memoryCache(sink))),
  });
}
