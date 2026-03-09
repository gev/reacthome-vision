import 'package:flutter/material.dart';
import 'package:glue/error.dart';
import 'package:glue/eval.dart';
import 'package:glue/ir.dart';
import 'package:vision/navigation/app_route.dart';

/// Creates a Route from a Widget
final Ir route = IrNativeFunc((Ir widgetIr) {
  return switch (widgetIr) {
    IrNativeValue(value: Value(value: Widget widget)) => Eval.pure(
      IrNativeValue(Value(makeRoute(widget))),
    ),
    _ => throwError(wrongArgumentType(['widget'])),
  };
});
