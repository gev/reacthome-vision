import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:glue/error.dart';
import 'package:glue/eval.dart';
import 'package:glue/ir.dart';

/// Creates a Theme widget from an IrObject
final Ir withTheme = IrNativeFunc(withThemeImpl);

Eval<Ir> withThemeImpl(Ir ir) {
  switch (ir) {
    case IrObject(:final properties):
      final data = to<ThemeData>(properties['data']);
      if (data == null) {
        return throwError(
          wrongArgumentType(['ThemeData `data` property required']),
        );
      }
      final child = to<Widget>(properties['child']);
      if (child == null) {
        return throwError(
          wrongArgumentType(['Widget `child` property required']),
        );
      }
      return Eval.pure(IrNativeValue(Value(Theme(data: data, child: child))));

    default:
      return throwError(
        wrongArgumentType(['Required theme properties: data and child']),
      );
  }
}
