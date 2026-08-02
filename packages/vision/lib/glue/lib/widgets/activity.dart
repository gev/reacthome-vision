import 'package:flutter/material.dart';
import 'package:glue/error.dart';
import 'package:glue/eval.dart';
import 'package:glue/ir.dart';

final activity = IrNativeFunc((Ir ir) {
  switch (ir) {
    case IrObject(:final properties):
      final color = to<Color>(properties['color']);
      final animatedColor = color != null
          ? AlwaysStoppedAnimation(color)
          : null;
      final valueColor = to<Animation<Color?>>(properties['value-color']);
      return Eval.pure(
        IrNativeValue(
          Value(
            CircularProgressIndicator.adaptive(
              value: toDouble(properties['value']),
              padding: to<EdgeInsetsGeometry>(properties['padding']),
              strokeWidth: toDouble(properties['stroke-width']),
              strokeCap: to<StrokeCap>(properties['stroke-cap']),
              strokeAlign: toDouble(properties['stroke-align']),
              valueColor: valueColor ?? animatedColor,
              backgroundColor: to<Color>(properties['background-color']),
              constraints: to<BoxConstraints>(properties['constraints']),
            ),
          ),
        ),
      );
    default:
      return throwError(wrongArgumentType(['`Object` propertis required']));
  }
});
