import 'package:glue/eval.dart';
import 'package:glue/ir.dart';

final Ir paint = IrNativeFunc(paintImpl);

Eval<Ir> paintImpl(Ir ir) {
  return Eval.pure(IrVoid());
}
