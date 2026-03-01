import 'package:glue/ir.dart';
import 'package:vision/glue/store/fetch.dart';
import 'package:vision/store/lookup/fetched_lookup.dart';
import 'package:vision/store/put/memory_put.dart';
import 'package:vision/store/store.dart';

Store<String, Ir> memoryCache(Sink<String> sink) {
  return Store<String, Ir>(
    lookup: (internalStore) => FetchedLookup(internalStore, fetch(sink)),
    put: (internalStore) => MemoryPut(internalStore),
  );
}
