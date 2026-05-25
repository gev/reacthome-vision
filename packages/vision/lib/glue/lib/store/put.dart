// /// Put operation for store
import 'package:glue/error.dart';
import 'package:glue/eval.dart';
import 'package:glue/ir.dart';
import 'package:vision/stores/store.dart';

final Ir put = IrSpecial(putImpl);

Eval<Ir> putImpl(List<Ir> args) => switch (args) {
  [final store, final key, final value] => eval(
    store,
  ).flatMap((s) => eval(key).flatMap((k) => putValue(s, k, value))),
  _ => throwError(wrongArgumentType(['store', 'key', 'value'])),
};

Eval<Ir> putValue(Ir store, Ir key, Ir value) {
  switch ((store, key)) {
    case (
      IrNativeValue(value: Value(value: ReactiveStore<String, Ir> s)),
      IrString(value: String k),
    ):
      s.store(k, value);
      return Eval.pure(IrVoid());
    case _:
      return throwError(wrongArgumentType(['store', 'key', 'value']));
  }
}
