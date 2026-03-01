import 'package:glue/error.dart';
import 'package:glue/eval.dart';
import 'package:glue/ir.dart';
import 'package:vision/store/lookup.dart';

final Ir lookupFunction = IrNativeFunc(lookupImpl);

Eval<Ir> lookupImpl(Ir store) {
  return Eval.pure(IrNativeFunc(lookupStore(store)));
}

Eval<Ir> Function(Ir) lookupStore(Ir store) {
  return (Ir key) => Eval.pure(IrNativeFunc(lookupKey(store, key)));
}

Eval<Ir> Function(Ir) lookupKey(Ir store, Ir key) {
  return (Ir defaultValue) => lookupValue(store, key, defaultValue);
}

Eval<Ir> lookupValue(Ir store, Ir key, Ir defaultValue) {
  switch (store) {
    case IrNativeValue(value: Value(value: Lookup<Ir, Ir> s)):
      final res = s.lookup(key, defaultValue);
      return Eval.pure(IrNativeValue(Value(res)));
    case _:
      return throwError(wrongArgumentType(['store', 'key', 'defaultValue']));
  }
}
