import 'package:flutter/widgets.dart';
import 'package:glue/context.dart';
import 'package:glue/either.dart';
import 'package:glue/eval.dart';
import 'package:glue/ir.dart';
import 'package:glue_flutter/glue_flutter.dart';
import 'package:vision/glue/lib/navigation/find_navigator.dart';

/// Pops routes until a predicate closure returns true
Ir popUntil(bool rootNavigator) => IrNativeFunc((Ir ir) {
  return getRuntime().bind((runtime) {
    final context = getFromContext<BuildContext>(runtime.context);
    if (context != null) {
      final targetNavigator = switch (ir) {
        IrObject(:final properties) => extractFromGlobalKey(
          properties['target'],
        ),
        _ => null,
      };
      final predicateIr = switch (ir) {
        IrObject(:final properties) =>
          properties['predicate'] ?? properties['route'],
        IrClosure() => ir,
        _ => null,
      };

      final navigator = findNavigator(context, rootNavigator, targetNavigator);
      if (predicateIr is IrClosure) {
        navigator.popUntil((route) {
          final result = runEval(
            apply(predicateIr, [IrNativeValue(Value(route))]),
            runtime,
          );
          return switch (result) {
            Right(value: (IrBool(value: bool v), _)) => v,
            _ => false,
          };
        });
      }
    }
    return Eval.pure(IrVoid());
  });
});
