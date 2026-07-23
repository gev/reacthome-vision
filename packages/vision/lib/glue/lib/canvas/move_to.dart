import 'package:flutter/widgets.dart';
import 'package:glue/error.dart';
import 'package:glue/eval.dart';
import 'package:glue/ir.dart';

final Ir moveTo = IrNativeFunc((Ir arg) {
  switch (arg) {
    case IrObject(:final properties):
      final x = toDouble(properties['x']);
      if (x == null) {
        return throwError(wrongArgumentType(['X should be double']));
      }
      final y = toDouble(properties['y']);
      if (y == null) {
        return throwError(wrongArgumentType(['Y should be double']));
      }
      return Eval.pure(
        IrNativeValue(
          Value((Path path) {
            path.moveTo(x, y);
          }),
        ),
      );
    default:
      return throwError(wrongArgumentType(['Object properties required']));
  }
});
