import 'package:glue/eval.dart';
import 'package:glue/ir.dart';

final Ir lineTo = IrNativeFunc(lineToImpl);

Eval<Ir> lineToImpl(Ir ir) {
  return Eval.pure(IrVoid());
}
