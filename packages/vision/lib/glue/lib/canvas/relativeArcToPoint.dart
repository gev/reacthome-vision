import 'package:flutter/widgets.dart';
import 'package:glue/error.dart';
import 'package:glue/eval.dart';
import 'package:glue/ir.dart';

Ir relativeArcToPoint = IrNativeFunc(relativeArcToPointImpl);

Eval<Ir> relativeArcToPointImpl(Ir ir) {
  switch (ir) {
    case IrObject(:final properties):
      final arcEndDelta = to<Offset>(properties['arc-end-delta']);
      if (arcEndDelta == null) {
        return throwError(
          wrongArgumentType(['`arc-end-delta` should be `Offset`']),
        );
      }
      return Eval.pure(
        IrNativeValue(
          Value((Path path) {
            path.relativeArcToPoint(
              arcEndDelta,
              radius: to<Radius>(properties['radius']) ?? Radius.zero,
              rotation: toDouble(properties['rotation']) ?? 0,
              largeArc: toBool(properties['large-arc']) ?? false,
              clockwise: toBool(properties['clock-wize']) ?? true,
            );
          }),
        ),
      );
    default:
      return throwError(wrongArgumentType(['`Object` properties required']));
  }
}
