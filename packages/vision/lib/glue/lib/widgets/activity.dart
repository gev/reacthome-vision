import 'package:flutter/material.dart';
import 'package:glue/error.dart';
import 'package:glue/eval.dart';
import 'package:glue/ir.dart';

final activity = IrNativeFunc(
  (Ir ir) => switch (ir) {
    IrObject(:final properties) => Eval.pure(
      IrNativeValue(
        Value(
          CircularProgressIndicator.adaptive(
            value: toDouble(properties['value']),
            valueColor: to<Animation<Color?>>(properties['value-color']),
            backgroundColor: to<Color>(properties['background-color']),
          ),
        ),
      ),
    ),
    _ => throwError(wrongArgumentType(['`Object` propertis required'])),
  },
);
