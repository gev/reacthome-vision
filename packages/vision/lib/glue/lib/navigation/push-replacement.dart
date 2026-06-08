import 'package:flutter/widgets.dart';
import 'package:glue/context.dart';
import 'package:glue/error.dart';
import 'package:glue/eval.dart';
import 'package:glue/ir.dart';
import 'package:vision/navigation/app_navigator.dart';

/// Replaces the current route with a new Route
final Ir pushReplacement = IrNativeFunc((Ir routeIr) {
  return switch (routeIr) {
    IrNativeValue(value: Value(value: Route route)) => getRuntime().flatMap((
      runtime,
    ) {
      final context = getFromContext<BuildContext>(runtime.context);
      return Eval.pure(
        IrNativeValue(
          Value(
            context != null
                ? Navigator.of(context).pushReplacement(route)
                : AppNavigator.pushReplacement(route),
          ),
        ),
      );
    }),
    _ => throwError(wrongArgumentType(['route'])),
  };
});
