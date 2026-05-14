import 'package:flutter/widgets.dart';
import 'package:glue/eval.dart';
import 'package:glue/ir.dart';

/// Creates a reactive state with Value getters
/// Returns IrNativeValue(Value(StateNotifier))
final state = IrNativeFunc((Ir initialValue) {
  final notifier = ValueNotifier(initialValue);
  return Eval.pure(IrNativeValue(hostValue(notifier)));
});
