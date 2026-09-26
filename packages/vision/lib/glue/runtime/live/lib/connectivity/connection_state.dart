import 'package:glue/ir.dart';
import 'package:vision/websocket/connection_state.dart';

Ir connectionStatus = IrObject({
  'connected': IrNativeValue(Value(ConnectionStatus.connected)),
  'connecting': IrNativeValue(Value(ConnectionStatus.connecting)),
  'disconnected': IrNativeValue(Value(ConnectionStatus.disconnected)),
});
