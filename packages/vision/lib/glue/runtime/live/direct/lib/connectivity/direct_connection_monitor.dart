import 'package:glue/eval.dart';
import 'package:glue/ir.dart';
import 'package:vision/connection/connection_monitor.dart';

Ir directConnectionMonitor(ConnectionMonitor monitor) => IrEvaluable(() {
  return Eval.pure(IrNativeValue(Value(monitor)));
});
