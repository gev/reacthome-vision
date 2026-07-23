import 'package:flutter/widgets.dart';
import 'package:glue/eval.dart';
import 'package:glue/ir.dart';

final localState = IrNativeFunc((Ir initialValue) {
  final notifier = ValueNotifier(initialValue);
  return Eval.pure(IrNativeValue(Value(notifier)));
});
