import 'package:flutter/painting.dart';
import 'package:glue/eval.dart';
import 'package:glue/ir.dart';
import 'package:vision/glue/lib/canvas/handler.dart';

final Ir group = IrSpecial(groupImpl);

Eval<Ir> groupImpl(List<Ir> rawArgs) {
  return sequenceAll(rawArgs.map(eval).toList()).bind((commands) {
    return Eval.pure(IrNativeValue(Value(makeGroup(commands))));
  });
}

CanvasHandler makeGroup(List<Ir> commands) => (Canvas canvas) {
  for (final command in commands) {
    if (command case IrNativeValue(
      value: Value(value: final CanvasHandler handle),
    )) {
      handle(canvas);
    }
  }
};
