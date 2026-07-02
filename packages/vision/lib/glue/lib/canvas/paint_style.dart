import 'dart:ui';

import 'package:glue/error.dart';
import 'package:glue/eval.dart';
import 'package:glue/ir.dart';

final Ir paintStyle = IrNativeFunc(paintStyleImpl);

Eval<Ir> paintStyleImpl(Ir ir) {
  switch (ir) {
    case IrObject(:final properties):
      final paint = Paint();
      try {
        for (final entry in properties.entries) {
          void apply<T>(T? Function(Ir ir) to, void Function(T v) set) {
            final value = to(entry.value);
            if (value == null) {
              throw wrongArgumentType(['property `${entry.key}` should be $T']);
            }
            set(value);
          }

          switch (entry.key) {
            case "blend-mode":
              apply(to<BlendMode>, (value) => paint.blendMode = value);
            case "color":
              apply(to<Color>, (value) => paint.color = value);
            case "color-filter":
              apply(to<ColorFilter>, (value) => paint.colorFilter = value);
            case "filter-quality":
              apply(to<FilterQuality>, (value) => paint.filterQuality = value);
            case "image-filter":
              apply(to<ImageFilter>, (value) => paint.imageFilter = value);
            case "invert-colors":
              apply(toBool, (value) => paint.invertColors = value);
            case "is-anti-alias":
              apply(toBool, (value) => paint.isAntiAlias = value);
            case "mask-filter":
              apply(to<MaskFilter>, (value) => paint.maskFilter = value);
            case "shader":
              apply(to<Shader>, (value) => paint.shader = value);
            case "stroke-cap":
              apply(to<StrokeCap>, (value) => paint.strokeCap = value);
            case "stroke-join":
              apply(to<StrokeJoin>, (value) => paint.strokeJoin = value);
            case "stroke-miter-limit":
              apply(toDouble, (value) => paint.strokeMiterLimit = value);
            case "stroke-width":
              apply(toDouble, (value) => paint.strokeWidth = value);
            case "style":
              apply(to<PaintingStyle>, (value) => paint.style = value);
          }
        }
        return Eval.pure(IrNativeValue(Value(paint)));
      } on RuntimeException catch (err) {
        return throwError(err);
      }
    default:
      return throwError(wrongArgumentType(['`Object` propertis required']));
  }
}
