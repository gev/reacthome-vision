import 'package:flutter/widgets.dart';
import 'package:glue/either.dart';
import 'package:glue/error.dart';
import 'package:glue/eval.dart';
import 'package:glue/ir.dart';
import 'package:vision/navigation/app_navigator.dart';

/// Pops routes until a predicate closure returns true
final Ir popUntil = IrNativeFunc((Ir predicateIr) {
  switch (predicateIr) {
    case IrClosure():
      return Eval((runtime) {
        // Transform closure evaluation into predicate function
        predicate(Route<dynamic> route) {
          final result = runEval(
            apply(predicateIr, [IrNativeValue(Value(route))]),
            runtime,
          );
          return switch (result) {
            Right(value: (IrBool(value: bool v), _)) => v,
            // ToDd: report error when result is a Future
            _ => false,
          };
        }

        AppNavigator.popUntil(predicate);
        return Right((IrVoid(), runtime));
      });
    default:
      return throwError(wrongArgumentType(['predicate']));
  }
});
