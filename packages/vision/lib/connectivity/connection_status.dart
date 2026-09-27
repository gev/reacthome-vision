import 'package:glue/ir.dart';
import 'package:vision/connection/connection_status.dart';

Ir connectionStatus = IrObject({
  'connected': IrNativeValue(Value(ConnectionStatus.connected)),
  'connecting': IrNativeValue(Value(ConnectionStatus.connecting)),
  'disconnected': IrNativeValue(Value(ConnectionStatus.disconnected)),
});
