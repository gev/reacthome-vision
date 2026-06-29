import 'package:glue/eval.dart';
import 'package:glue/ir.dart';

final Ir canvas = IrNativeFunc(canvasImpl);

Eval<Ir> canvasImpl(Ir ir) {
  return Eval.pure(IrVoid());
}
