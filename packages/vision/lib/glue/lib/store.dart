import 'package:glue/module.dart';
import 'package:vision/glue/lib/store/lookup_function.dart';
import 'package:vision/glue/lib/store/put_function.dart';

/// Generic store module providing key-value storage
final storeModule = nativeModule('ffi.store', [('put', put), ('get', lookup)]);
