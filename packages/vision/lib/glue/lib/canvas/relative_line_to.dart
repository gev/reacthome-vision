import 'package:flutter/widgets.dart';
import 'package:glue/error.dart';
import 'package:glue/eval.dart';
import 'package:glue/ir.dart';

final Ir relativeLineTo = IrNativeFunc((Ir arg) {
  switch (arg) {
    case IrObject(:final properties):
      final dx = toDouble(properties['dx']);
      if (dx == null) {
        return throwError(wrongArgumentType(['dx should be double']));
      }
      final dy = toDouble(properties['dy']);
      if (dy == null) {
        return throwError(wrongArgumentType(['dy should be double']));
      }
      return Eval.pure(
        IrNativeValue(
          Value((Path path) {
            path.relativeLineTo(dx, dy);
          }),
        ),
      );
    default:
      return throwError(wrongArgumentType(['Object properties required']));
  }
});
