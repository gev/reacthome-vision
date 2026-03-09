import 'package:flutter/widgets.dart';
import 'package:glue/error.dart';
import 'package:glue/eval.dart';
import 'package:glue/ir.dart';
import 'package:vision/navigation/app_navigator.dart';

/// Pushes a Route onto the navigation stack
final Ir push = IrNativeFunc((Ir routeIr) {
  return switch (routeIr) {
    IrNativeValue(value: Value(value: Route route)) => Eval.pure(
      IrNativeValue(Value(AppNavigator.push(route))),
    ),
    _ => throwError(wrongArgumentType(['route'])),
  };
});
