import 'package:glue/eval.dart';
import 'package:glue/ir.dart';
import 'package:vision/glue/extract.dart';
import 'package:vision/widgets/screen.dart';

final screen = IrNativeFunc(screenImpl);

Eval<Ir> screenImpl(Ir ir) {
  return Eval.pure(IrNativeValue(Value(Screen(body: extractWidget(ir)))));
}
