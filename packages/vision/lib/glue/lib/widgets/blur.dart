import 'dart:ui';

import 'package:glue/error.dart';
import 'package:glue/eval.dart';
import 'package:glue/ir.dart';

final Ir blur = IrNativeFunc((props) {
  return switch (props) {
    IrObject(:final properties) => Eval.pure(
      IrNativeValue(
        Value(
          ImageFilter.blur(
            sigmaX: toDouble(properties['sigma-x']) ?? 0,
            sigmaY: toDouble(properties['sigma-y']) ?? 0,
            tileMode: to<TileMode>(properties['tile-mode']),
            bounds: to<Rect>(properties['bounds']),
          ),
        ),
      ),
    ),
    _ => throwError(
      wrongArgumentType(['`Object` sigma-x and sigma-y required']),
    ),
  };
});
