import 'package:glue/ir.dart';
import 'package:vision/glue/store/tmp.dart';
import 'package:vision/stores/store.dart';

typedef StoreFactory =
    ReactiveStore<String, Ir> Function(
      String prefix,
      String name,
      Sink<String> sink,
    );

(String, IrObject) stores(String prefix, Sink<String> sink) {
  return (prefix, store(prefix, 'tmp', sink, tmp));
}

IrObject store(
  String prefix,
  String name,
  Sink<String> sink,
  StoreFactory store,
) => IrObject({name: IrNativeValue(Value(store(prefix, name, sink)))});
