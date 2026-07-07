// /// Put operation for store
import 'package:glue/error.dart';
import 'package:glue/eval.dart';
import 'package:glue/ir.dart';
import 'package:vision/glue/pub_sub/glue_subscriber.dart';

Ir put(GlueSubscriber subscriber) {
  Eval<Ir> putImpl(List<Ir> args) {
    switch (args) {
      case [
        IrString(value: final key),
        IrInteger(value: final version),
        Ir value,
      ]:
      case [
        IrSymbol(value: final key),
        IrInteger(value: final version),
        Ir value,
      ]:
      case [
        IrDottedSymbol(value: final key),
        IrInteger(value: final version),
        Ir value,
      ]:
        subscriber.publish(key, (payload: value, version: version));
        return Eval.pure(IrVoid());
      case _:
        return throwError(wrongArgumentType(['key', 'version', 'value']));
    }
  }

  return IrSpecial(putImpl);
}
