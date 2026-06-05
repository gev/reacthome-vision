import 'package:glue/error.dart';
import 'package:glue/eval.dart';
import 'package:glue/ir.dart';
import 'package:vision/glue/pub_sub/glue_subscriber.dart';

Ir import(ModuleSubscriber subscriber) {
  Eval<Ir> importImpl(List<Ir> args) {
    switch (args) {
      case [IrDottedSymbol name]:
        subscriber.subscribe(name);
        return Eval.pure(IrVoid());
      default:
        return throwError(wrongArgumentType(['module name required']));
    }
  }

  return IrSpecial(importImpl);
}
