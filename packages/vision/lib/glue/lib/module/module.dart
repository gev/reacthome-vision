// /// Put operation for store
import 'package:glue/error.dart';
import 'package:glue/eval.dart';
import 'package:glue/ir.dart';
import 'package:vision/glue/pub_sub/glue_subscriber.dart';

Ir module(ModuleSubscriber subscriber) {
  Eval<Ir> moduleImpl(List<Ir> args) {
    switch (args) {
      case [final IrDottedSymbol name, final Ir exports, ...final Ir body]:
        subscriber.publish(name, (exports: exports, body: body));
        return Eval.pure(IrVoid());
      case _:
        return throwError(wrongArgumentType(['name', 'exports', 'body']));
    }
  }

  return IrSpecial(moduleImpl);
}
