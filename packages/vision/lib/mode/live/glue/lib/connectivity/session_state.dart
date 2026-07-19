import 'package:glue/ir.dart';
import 'package:vision/mode/live/session/session_state.dart';

Ir sessionState = IrObject({
  'connected': IrNativeValue(Value(SessionState.connected)),
  'connecting': IrNativeValue(Value(SessionState.connecting)),
  'disconnected': IrNativeValue(Value(SessionState.disconnected)),
});
