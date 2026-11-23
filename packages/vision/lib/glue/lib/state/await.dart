import 'dart:async';

import 'package:glue/either.dart';
import 'package:glue/error.dart';
import 'package:glue/eval.dart';
import 'package:glue/ir.dart';

/// Runs a Glue function once when one or more Futures complete.
/// Usage: (await (lambda (values) ...) [future ...])
final awaitFuture = IrNativeFunc((Ir lambda) {
  return Eval.pure(
    IrSpecial((List<Ir> rawArgs) {
      return sequenceAll(rawArgs.map(eval).toList()).bind((args) {
        final (futureArgs, isList) = switch (args) {
          [IrList(:final elements)] => (elements.unlock, true),
          _ => (args, false),
        };
        final futures = futureArgs.map(to<Future>).toList();

        if (futures.isEmpty || futures.any((future) => future == null)) {
          return throwError(
            wrongArgumentType(['`function`', 'one or more Futures']),
          );
        }

        final allFutures = futures.cast<Future>();
        return Eval((runtime) {
          final zone = Zone.current;
          Future.wait(allFutures).then<void>(
            (value) {
              final values = value.map((item) {
                return item is Ir ? item : toIr(item);
              }).toList();
              final result = runEval(
                apply(lambda, isList ? [IrList(values)] : values),
                runtime,
              );
              result.match(
                (error) => zone.handleUncaughtError(error, StackTrace.current),
                (_) {},
              );
            },
            onError: (Object error, StackTrace stackTrace) {
              zone.handleUncaughtError(error, stackTrace);
            },
          );
          return Right((IrVoid(), runtime));
        });
      });
    }),
  );
});
