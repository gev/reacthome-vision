import 'package:glue/eval.dart';
import 'package:glue/ir.dart';
import 'package:vision/websocket/connection_monitor.dart';

Ir localConnectionMonitor(ConnectionMonitor monitor) => IrEvaluable(() {
  return Eval.pure(IrNativeValue(Value(monitor)));
});
