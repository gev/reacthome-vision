import 'package:glue/error.dart';
import 'package:glue/eval.dart';
import 'package:glue/ir.dart';
import 'package:vision/glue/stores/glue_subscribable.dart';

final Ir lookup = IrNativeFunc(lookupImpl);

Eval<Ir> lookupImpl(Ir store) {
  return Eval.pure(IrNativeFunc(lookupStore(store)));
}

Eval<Ir> Function(Ir) lookupStore(Ir store) {
  return (Ir key) => lookupKey(store, key);
}

Eval<Ir> lookupKey(Ir store, Ir key) {
  switch ((store, key)) {
    case (
      IrNativeValue(value: Value(value: GlueSubscribable s)),
      IrString(value: final key),
    ):
    case (
      IrNativeValue(value: Value(value: GlueSubscribable s)),
      IrSymbol(value: final key),
    ):
    case (
      IrNativeValue(value: Value(value: GlueSubscribable s)),
      IrDottedSymbol(value: final key),
    ):
      final res = s.lookup(key, IrVoid());
      return Eval.pure(IrNativeValue(Value(res)));
    case _:
      return throwError(wrongArgumentType(['store', 'key']));
  }
}
