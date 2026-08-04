import 'package:flutter/widgets.dart';
import 'package:glue/error.dart';
import 'package:glue/eval.dart';
import 'package:glue/ir.dart';
import 'package:vision/glue/widgets/glue_listenable.dart';

/// Creates a GlueListenable that rebuilds when dependencies change
/// Takes a lambda function that receives the current value and list of ValueNotifiers
final render = IrNativeFunc((Ir lambda) {
  return Eval.pure(
    IrSpecial((List<Ir> rawArgs) {
      return sequenceAll(rawArgs.map(eval).toList()).bind((List<Ir> args) {
        final notifiers = <ValueNotifier>[];
        for (final arg in args) {
          switch (arg) {
            case IrList(:final elements):
              for (final item in elements) {
                final notifier = to<ValueNotifier>(item);
                if (notifier != null) {
                  notifiers.add(notifier);
                }
              }
            default:
              final notifier = to<ValueNotifier>(arg);
              if (notifier != null) {
                notifiers.add(notifier);
              }
          }
        }
        if (notifiers.isEmpty) {
          return throwError(
            wrongArgumentType(['`function`', 'list of `ValueNotifier`']),
          );
        }
        final reactiveContainer = GlueListenable(
          notifiers: notifiers,
          lambda: lambda,
        );
        return Eval.pure(IrNativeValue(Value(reactiveContainer)));
      });
    }),
  );
});
