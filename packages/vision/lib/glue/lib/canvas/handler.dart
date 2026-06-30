import 'package:flutter/painting.dart';
import 'package:glue/error.dart';
import 'package:glue/eval.dart';
import 'package:glue/ir.dart';

typedef CanvasHandler = void Function(Canvas path);
typedef PathHandler = void Function(Path path);
typedef PathHandlerXY = PathHandler Function(double x, double y);

Ir handleXY(PathHandlerXY handle) {
  return IrNativeFunc((Ir irX) {
    final x = toDouble(irX);
    if (x == null) {
      return throwError(wrongArgumentType(['`x` should be numbers']));
    }
    return Eval.pure(
      IrNativeFunc((Ir irY) {
        final y = toDouble(irY);
        if (y == null) {
          return throwError(wrongArgumentType(['`y` should be numbers']));
        }
        return Eval.pure(IrNativeValue(Value(handle(x, y))));
      }),
    );
  });
}
