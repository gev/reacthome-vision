import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:glue/eval.dart';
import 'package:glue/ir.dart';
import 'package:vision/notifier.dart';

/// Creates an optimistic state with a given timeout.
final optimisticState = IrNativeFunc((Ir timeoutIr) {
  final timeout = to<Duration>(timeoutIr) ?? Duration(seconds: 1);
  return Eval.pure(
    IrNativeFunc((Ir initialValueIr) {
      final valueNotifier = ValueNotifier(initialValueIr);
      Timer? rollbackTimer;
      final writeNotifier = WriteNotifier.wrap(valueNotifier, (Ir newValue) {
        valueNotifier.value = newValue;
        rollbackTimer?.cancel();
        rollbackTimer = Timer(timeout, () {
          valueNotifier.value = initialValueIr;
        });
      });
      return Eval.pure(IrNativeValue(Value(writeNotifier)));
    }),
  );
});
