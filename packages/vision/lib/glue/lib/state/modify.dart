import 'package:glue/either.dart';
import 'package:glue/error.dart';
import 'package:glue/eval.dart';
import 'package:glue/ir.dart';
import 'package:vision/notifier.dart';

/// Modifies a reactive state atomically
/// Usage: (modify state (lambda (current-value) new-value))
final modify = IrNativeFunc((Ir stateIr) {
  return Eval.pure(
    IrNativeFunc((Ir lambdaIr) {
      return Eval((runtime) {
        final state = switch (stateIr) {
          IrNativeValue(value: final hv) => extractValue<WriteNotifier<Ir>>(hv),
          _ => null,
        };
        if (state == null) {
          return Left(
            EvalError(
              [],
              RuntimeException(
                'invalid-argument',
                IrString('Expected WriteNotifier'),
              ),
            ),
          );
        }
        final result = runEval(apply(lambdaIr, [state.value]), runtime);
        return result.match((error) => Left(error), (value) {
          state.write(value.$1);
          return Right((IrVoid(), runtime));
        });
      });
    }),
  );
});
