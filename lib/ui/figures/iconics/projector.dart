import 'dart:ui';

import 'package:studio/ui/figures/iconic.dart';

const kProjectorWidth = 0.5;
const kProjectorHeight = 0.4;
const kProjectorGap = 0.08;
const kSmallCircleSize = 0.08;
const kBigCircleSize = 0.25;

class ProjectorIconic extends Iconic {
  final Path _path = Path();
  final double conditionerWidth;
  final double conditionerHeight;
  final double conditionerGap;
  final double smallCircleSize;
  final double bigCircleSize;
  ProjectorIconic({required super.offset, required super.size, required super.iconicStyle})
    : conditionerWidth = size * kProjectorWidth,
      conditionerHeight = size * kProjectorHeight,
      conditionerGap = size * kProjectorGap,
      smallCircleSize = size * kSmallCircleSize,
      bigCircleSize = size * kBigCircleSize {
    _path
      ..moveTo(offset.dx - conditionerWidth, offset.dy + (conditionerHeight - conditionerGap))
      ..relativeLineTo(2 * conditionerWidth, 0)
      ..addRect(
        Rect.fromPoints(
          Offset(offset.dx - conditionerWidth, offset.dy + conditionerHeight),
          Offset(offset.dx + conditionerWidth, offset.dy - conditionerHeight),
        ),
      )
      ..moveTo(
        offset.dx + (conditionerWidth - conditionerGap),
        offset.dy + (conditionerHeight - 2.5 * conditionerGap),
      )
      ..addOval(Rect.fromCircle(center: offset, radius: smallCircleSize))
      ..moveTo(
        offset.dx + (conditionerWidth - conditionerGap),
        offset.dy + (conditionerHeight - 2.5 * conditionerGap),
      )
      ..relativeLineTo(-conditionerGap, 0)
      ..addOval(Rect.fromCircle(center: offset, radius: bigCircleSize));
  }
  @override
  void paint(Canvas canvas) {
    canvas.drawPath(_path, strokeStyle);
  }
}
