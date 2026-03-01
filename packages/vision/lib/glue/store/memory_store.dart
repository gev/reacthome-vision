import 'package:glue/ir.dart';
import 'package:vision/store/lookup/simple_lookup.dart';
import 'package:vision/store/put/memory_put.dart';
import 'package:vision/store/store.dart';

final memoryStore = Store<String, Ir>(
  lookup: (internalStore) => SimpleLookup(internalStore),
  put: (internalStore) => MemoryPut(internalStore),
);
