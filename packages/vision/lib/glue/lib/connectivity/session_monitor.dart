import 'package:glue/eval.dart';
import 'package:glue/ir.dart';
import 'package:vision/session/session_monitor.dart';

Ir localSessionMonitor(SessionMonitor monitor) => IrEvaluable(() {
  return Eval.pure(IrNativeValue(Value(monitor)));
});
