import 'package:glue/error.dart';
import 'package:glue/eval.dart';
import 'package:glue/ir.dart';
import 'package:vision/glue/stores/glue_store.dart';
import 'package:vision/notifier.dart';

Ir lookupReadOnly({required GlueReactiveLookup lookup}) {
  return IrNativeFunc((Ir key) {
    switch (key) {
      case IrString(value: final key):
      case IrSymbol(value: final key):
      case IrDottedSymbol(value: final key):
        final valueNotifier = lookup.lookup(key, IrVoid());
        return Eval.pure(IrNativeValue(Value(valueNotifier)));
      case _:
        return throwError(wrongArgumentType(['key']));
    }
  });
}

Ir lookupReadWrite({required GlueReactiveLookup lookup, required GluePut put}) {
  return IrNativeFunc((Ir key) {
    switch (key) {
      case IrString(value: final key):
      case IrSymbol(value: final key):
      case IrDottedSymbol(value: final key):
        final valueNotifier = lookup.lookup(key, IrVoid());
        final writeNotifier = WriteNotifier.wrap(valueNotifier, (Ir newValue) {
          put.put(key, (
            payload: newValue,
            version: DateTime.timestamp().millisecondsSinceEpoch,
          ));
        });
        return Eval.pure(IrNativeValue(Value(writeNotifier)));
      case _:
        return throwError(wrongArgumentType(['key']));
    }
  });
}
