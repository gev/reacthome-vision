// /// Put operation for store
import 'package:glue/error.dart';
import 'package:glue/eval.dart';
import 'package:glue/ir.dart';
import 'package:vision/glue/pub_sub/glue_subscriber.dart';

Ir module(ModuleSubscriber subscriber) {
  Eval<Ir> moduleImpl(List<Ir> args) {
    switch (args) {
      case [IrList exports, Ir body]:
        print(exports);
        print(body);
        return Eval.pure(IrVoid());
      case _:
        return throwError(wrongArgumentType(['name', 'body']));
    }
  }

  return IrSpecial(moduleImpl);
}
