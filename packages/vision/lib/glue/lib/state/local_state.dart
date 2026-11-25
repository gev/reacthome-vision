import 'package:glue/eval.dart';
import 'package:glue/ir.dart';
import 'package:material_ui/material_ui.dart';
import 'package:vision/util/notifier.dart';

final localState = IrNativeFunc((Ir initialValue) {
  final valueNotifier = ValueNotifier(initialValue);
  final writeNotifier = WriteNotifier.wrap(valueNotifier, ((Ir newValue) {
    valueNotifier.value = newValue;
  }));
  return Eval.pure(IrNativeValue(Value(writeNotifier)));
});
