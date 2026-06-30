import 'package:flutter/painting.dart';
import 'package:glue/eval.dart';
import 'package:glue/ir.dart';
import 'package:vision/glue/lib/canvas/handler.dart';

final Ir paint = IrSpecial(paintImpl);

Eval<Ir> paintImpl(List<Ir> rawArgs) {
  return sequenceAll(rawArgs.map(eval).toList()).bind((commands) {
    return Eval.pure(IrNativeValue(Value(run(commands))));
  });
}

CanvasHandler run(List<Ir> commands) => (Canvas canvas) {
  for (final command in commands) {
    if (command case IrNativeValue(
      value: Value(value: final CanvasHandler handle),
    )) {
      handle(canvas);
    }
  }
};
