import 'package:glue/eval.dart';
import 'package:glue/ir.dart';

final Ir path = IrNativeFunc(pathImpl);

Eval<Ir> pathImpl(Ir ir) {
  return Eval.pure(IrVoid());
}
