import 'package:glue/error.dart';
import 'package:glue/eval.dart';
import 'package:glue/ir.dart';
import 'package:glue/module/import.dart';
import 'package:vision/glue/pub_sub/glue_subscriber.dart';
import 'package:vision/glue/stores/reactive_runtime.dart';

Ir import(GlueSubscriber subscriber, ReactiveRuntime runtime) {
  Eval<Ir> importImpl(List<Ir> args) {
    switch (args) {
      case [IrSymbol(value: final name)]:
      case [IrDottedSymbol(value: final name)]:
        subscriber.subscribe(name, runtime);
        return importModule(name);
      default:
        return throwError(wrongArgumentType(['module name required']));
    }
  }

  return IrSpecial(importImpl);
}
