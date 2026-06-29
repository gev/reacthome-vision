import 'package:flutter/widgets.dart';
import 'package:glue/either.dart';
import 'package:glue/error.dart';
import 'package:glue/eval.dart';
import 'package:glue/ir.dart';

/// Modifies a reactive state atomically
/// Usage: (modify state (lambda (current-value) new-value))
final modify = IrNativeFunc((Ir stateIr) {
  return Eval.pure(
    IrNativeFunc((Ir lambdaIr) {
      return Eval((runtime) async {
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
        final result = await runEval(apply(lambdaIr, [state.value]), runtime);
        return result.match((error) => Left(error), (value) {
          state.value = value.$1;
          return Right((IrVoid(), runtime));
        });
      });
    }),
  );
});
