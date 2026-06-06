// /// Put operation for store
import 'package:glue/either.dart';
import 'package:glue/error.dart';
import 'package:glue/eval.dart';
import 'package:glue/ir.dart';
import 'package:glue/module/registration.dart';
import 'package:vision/glue/pub_sub/glue_subscriber.dart';

Ir module(ModuleSubscriber subscriber) {
  Eval<Ir> moduleImpl(List<Ir> args) {
    switch (parseModuleParts(args)) {
      case Left(value: final err):
        return throwError(wrongArgumentType([err]));
      case Right(value: final module):
        subscriber.publish(module.name, module);
        return Eval.pure(IrVoid());
    }
  }

  return IrSpecial(moduleImpl);
}
