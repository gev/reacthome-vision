// /// Put operation for store
import 'package:glue/error.dart';
import 'package:glue/eval.dart';
import 'package:glue/ir.dart';
import 'package:vision/store/put.dart';

final Ir putFunction = IrNativeFunc(putImpl);

Eval<Ir> putImpl(Ir store) {
  return Eval.pure(IrNativeFunc(putStore(store)));
}

Eval<Ir> Function(Ir) putStore(Ir store) {
  return (Ir key) => Eval.pure(IrNativeFunc(putKey(store, key)));
}

Eval<Ir> Function(Ir) putKey(Ir store, Ir key) {
  return (Ir value) => putValue(store, key, value);
}

Eval<Ir> putValue(Ir store, Ir key, Ir value) {
  switch ((store, key)) {
    case (
      IrNativeValue(value: Value(value: Put<String, Ir> s)),
      IrString(value: String k),
    ):
      s.put(k, value);
      return Eval.pure(IrVoid());
    case _:
      return throwError(wrongArgumentType(['store', 'key', 'value']));
  }
}
