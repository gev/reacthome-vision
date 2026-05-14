import 'package:flutter/widgets.dart';
import 'package:glue/ir.dart';

/// Helper function to extract ChangeNotifier from IrNativeValue
ValueNotifier<Ir>? extractStateNotifier(Ir ir) {
  return switch (ir) {
    IrNativeValue(value: Value(value: ValueNotifier<Ir> notifier)) => notifier,
    _ => null,
  };
}

/// Helper function to extract a single widget from Ir
Widget extractWidget(Ir ir) {
  final res = switch (ir) {
    IrNativeValue(value: Value(value: Widget widget)) => widget,
    _ => Text('Invalid widget'),
  };
  return res;
}
