import 'package:glue/ir.dart';
import 'package:vision/glue/store/memory_cache.dart';
import 'package:vision/glue/store/memory_store.dart';
import 'package:vision/store/pool.dart';

Ir storeObject(Sink<String> sink, Pool<String> pool) {
  return IrObject({
    'memory': IrNativeValue(Value(memoryStore)),
    'cache': IrNativeValue(Value(memoryCache(sink, pool))),
  });
}
