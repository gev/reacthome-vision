// /// Put operation for store
import 'package:glue/error.dart';
import 'package:glue/eval.dart';
import 'package:glue/ir.dart';
import 'package:vision/glue/pub_sub/glue_subscriber.dart';

Ir put(GlueSubscriber subscriber) {
  Eval<Ir> putImpl(List<Ir> args) {
    switch (args) {
      case [IrSymbol(value: final key), Ir value]:
      case [IrDottedSymbol(value: final key), Ir value]:
        subscriber.publish(key, value);
        return Eval.pure(IrVoid());
      case _:
        return throwError(wrongArgumentType(['key', 'value']));
    }
  }

  return IrSpecial(putImpl);
}
