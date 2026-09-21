import 'package:glue/eval.dart';
import 'package:glue/ir.dart';

Ir discovery = IrNativeFunc((Ir arg) {
  return Eval.pure(IrVoid());
});
