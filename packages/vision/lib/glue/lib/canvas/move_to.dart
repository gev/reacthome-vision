import 'package:glue/eval.dart';
import 'package:glue/ir.dart';

final Ir moveTo = IrNativeFunc(moveToImpl);

Eval<Ir> moveToImpl(Ir ir) {
  return Eval.pure(IrVoid());
}
