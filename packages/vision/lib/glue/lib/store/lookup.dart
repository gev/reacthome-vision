import 'package:glue/error.dart';
import 'package:glue/eval.dart';
import 'package:glue/ir.dart';
import 'package:vision/glue/stores/glue_store.dart';

Ir lookup(GlueReactiveLookup store) {
  return IrNativeFunc((Ir key) {
    switch (key) {
      case IrString(value: final key):
      case IrSymbol(value: final key):
      case IrDottedSymbol(value: final key):
        final res = store.lookup(key, IrVoid());
        return Eval.pure(IrNativeValue(Value(res)));
      case _:
        return throwError(wrongArgumentType(['key']));
    }
  });
}
