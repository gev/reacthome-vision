import 'package:glue/error.dart';
import 'package:glue/eval.dart';
import 'package:glue/ir.dart';
import 'package:glue/module/import.dart';
import 'package:vision/mode/local/glue/local_reactive_runtime.dart';

Ir localImport(LocalReactiveRuntime runtime) {
  Eval<Ir> importImpl(List<Ir> args) {
    switch (args) {
      case [IrSymbol(value: final name)]:
      case [IrDottedSymbol(value: final name)]:
        runtime.loadModule(name);
        return importModule(name);
      default:
        return throwError(wrongArgumentType(['module name required']));
    }
  }

  return IrSpecial(importImpl);
}
