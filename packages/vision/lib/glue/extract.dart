import 'package:flutter/widgets.dart';
import 'package:glue/ir.dart';

/// Helper function to extract ChangeNotifier from IrNativeValue
ValueNotifier<Ir>? extractStateNotifier(Ir ir) => switch (ir) {
  IrNativeValue(value: Value(value: ValueNotifier<Ir> notifier)) => notifier,
  _ => null,
};

/// Helper function to extract a single widget from Ir
Widget? extractWidget(Ir? ir) => switch (ir) {
  IrList(:final elements) => extractWidget(elements.lastOrNull),
  IrNativeValue(value: Value(value: Widget widget)) => widget,
  _ => null,
};
