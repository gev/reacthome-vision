import 'package:glue/either.dart';
import 'package:glue/error.dart';
import 'package:glue/eval.dart';
import 'package:glue/ir.dart';
import 'package:vision/notifier.dart';

/// Writes the value of a reactive state
/// Takes: state (IrNativeValue), returns function that takes newValue
/// Returns: IrVoid
final write = IrNativeFunc((Ir stateIr) {
  return Eval.pure(
    IrNativeFunc((Ir newValueIr) {
      return Eval((runtime) {
        final state = switch (stateIr) {
          IrNativeValue(value: final hv) => extractValue<WriteNotifier>(hv),
          _ => null,
        };
        if (state == null) {
          return Left(
            EvalError(
              [],
              RuntimeException(
                'invalid-argument',
                IrString('Expected WrireNotifier'),
              ),
            ),
          );
        }
        state.write(newValueIr);
        return Right((IrVoid(), runtime));
      });
    }),
  );
});
