import 'package:flutter/widgets.dart';
import 'package:glue/error.dart';
import 'package:glue/eval.dart';
import 'package:glue/ir.dart';
import 'package:vision/glue/widgets/glue_listenable.dart';
import 'package:vision/logger.dart';

/// Creates a ListenableWidget that rebuilds when dependencies change
/// Takes a StateNotifier and a lambda function that receives the current value
IrNativeFunc listen(Logger log) => IrNativeFunc((Ir notifierIr) {
  return Eval.pure(
    IrNativeFunc((Ir lambda) {
      // return Eval((runtime) {
      // Evaluate the notifier argument to get the actual StateNotifier object
      final notifier = switch (notifierIr) {
        IrNativeValue(value: final hv) => extractValue<ValueNotifier<Ir>>(hv),
        _ => null,
      };

      if (notifier == null) {
        return throwError(
          RuntimeException(
            'invalid-argument',
            IrString('Expected ValueNotifier'),
          ),
        );
      }

      // Create reactive widget that calls the lambda with current value
      final reactiveContainer = GlueListenable(
        notifier: notifier,
        lambda: lambda,
      );

      return Eval.pure(IrNativeValue(Value(reactiveContainer)));
    }),
  );
});
