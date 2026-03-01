import 'package:flutter/widgets.dart';
import 'package:glue/ir.dart';
import 'package:vision/state/state_notifier.dart';

/// Helper function to extract ChangeNotifier from IrNativeValue
StateNotifier<Ir>? extractStateNotifier(Ir ir) {
  return switch (ir) {
    IrNativeValue(value: Value(value: StateNotifier<Ir> notifier)) => notifier,
    _ => null,
  };
}

/// Helper function to extract a single widget from Ir
Widget extractWidget(Ir ir) {
  return switch (ir) {
    IrNativeValue(value: Value(value: Widget widget)) => widget,
    _ => const Text('Invalid widget'),
  };
}
