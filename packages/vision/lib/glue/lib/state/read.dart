import 'package:flutter/cupertino.dart';
import 'package:glue/either.dart';
import 'package:glue/error.dart';
import 'package:glue/eval.dart';
import 'package:glue/ir.dart';

/// Reads the value of a reactive state
/// Takes: state (IrNativeValue), returns the current value
/// Returns: Ir (the current state value)
final read = IrNativeFunc((Ir stateIr) {
  return Eval((runtime) {
    final state = switch (stateIr) {
      IrNativeValue(value: final hv) => extractValue<ValueNotifier>(hv),
      _ => null,
    };
    if (state == null) {
      return Left(
        EvalError(
          [],
          RuntimeException(
            'invalid-argument',
            IrString('Expected ValueNotifier'),
          ),
        ),
      );
    }
    return Right((state.value, runtime));
  });
});
