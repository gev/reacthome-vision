import 'package:flutter/painting.dart';
import 'package:glue/error.dart';
import 'package:glue/eval.dart';
import 'package:glue/ir.dart';
import 'package:vision/glue/lib/canvas/handler.dart';

final Ir path = IrSpecial(pathImpl);

Eval<Ir> pathImpl(List<Ir> rawArgs) {
  return sequenceAll(rawArgs.map(eval).toList()).bind((args) {
    final [irPaint, ...commands] = args;
    switch (irPaint) {
      case (IrNativeValue(value: Value(value: final Paint paint))):
        final path = Path();
        for (final command in commands) {
          if (command case IrNativeValue(
            value: Value(value: final PathHandler handle),
          )) {
            handle(path);
          }
        }
        return Eval.pure(
          IrNativeValue(
            Value((Canvas canvas) {
              canvas.drawPath(path, paint);
            }),
          ),
        );
      default:
        return throwError(
          wrongArgumentType(['First argument should be `Paint`']),
        );
    }
  });
}
