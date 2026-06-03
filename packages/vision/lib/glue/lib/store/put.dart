// /// Put operation for store
import 'package:glue/error.dart';
import 'package:glue/eval.dart';
import 'package:glue/ir.dart';
import 'package:vision/glue/pub_sub/glue_subscriber.dart';

Ir put(GlueSubscriber subscriber) {
  Eval<Ir> putValue(Ir key, Ir value) {
    switch (key) {
      case IrSymbol(value: String k):
        subscriber.publish(k, value);
        return Eval.pure(IrVoid());
      case _:
        return throwError(wrongArgumentType(['key', 'value']));
    }
  }

  Eval<Ir> putImpl(List<Ir> args) {
    switch (args) {
      case [final key, final value]:
        return eval(key).flatMap((k) {
          return putValue(k, value);
        });
      case _:
        return throwError(wrongArgumentType(['key', 'value']));
    }
  }

  return IrSpecial(putImpl);
}
