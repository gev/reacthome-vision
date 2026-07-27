import 'package:glue/error.dart';
import 'package:glue/eval.dart';
import 'package:glue/ir.dart';
import 'package:vision/glue/stores/glue_store.dart';

Ir persistentLocalState(GlueReactiveLookup store) => IrNativeFunc((Ir ir) {
  switch (ir) {
    case IrString(value: final key):
    case IrSymbol(value: final key):
    case IrDottedSymbol(value: final key):
      final value = store.lookup(key, IrVoid());
      return Eval.pure(IrNativeValue(Value(value)));
    default:
      return throwError(wrongArgumentType(['`key` state name required']));
  }
});
