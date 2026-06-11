import 'package:flutter/widgets.dart';
import 'package:glue/context.dart';
import 'package:glue/error.dart';
import 'package:glue/eval.dart';
import 'package:glue/ir.dart';

/// Pushes a Route onto the navigation stack
final Ir push = IrNativeFunc((Ir routeIr) {
  return switch (routeIr) {
    IrSymbol(value: final route) => getRuntime().bind((runtime) {
      final context = getFromContext<BuildContext>(runtime.context);
      return Eval.pure(
        context != null
            ? IrNativeValue(Value(Navigator.of(context).pushNamed(route)))
            : IrVoid(),
      );
    }),
    _ => throwError(wrongArgumentType(['route'])),
  };
});
