import 'dart:ui';

import 'package:studio/ui/figures/iconic.dart';

const kProjectorWidth = 0.5;
const kProjectorHeight = 0.4;
const kProjectorGap = 0.08;
const kSmallCircleSize = 0.08;
const kBigCircleSize = 0.25;

class ProjectorIconic extends Iconic {
  final Path _path = Path();

  ProjectorIconic({
    required super.offset,
    required super.size,
    required super.iconicStyle,
  }) {
    _path
      ..moveTo(
        offset.dx - projectorWidth,
        offset.dy + (projectorHeight - projectorGap),
      )
      ..relativeLineTo(2 * projectorWidth, 0)
      ..addRect(
        Rect.fromPoints(
          Offset(offset.dx - projectorWidth, offset.dy + projectorHeight),
          Offset(offset.dx + projectorWidth, offset.dy - projectorHeight),
        ),
      )
      ..moveTo(
        offset.dx + (projectorWidth - projectorGap),
        offset.dy + (projectorHeight - 2.5 * projectorGap),
      )
      ..addOval(Rect.fromCircle(center: offset, radius: smallCircleSize))
      ..moveTo(
        offset.dx + (projectorWidth - projectorGap),
        offset.dy + (projectorHeight - 2.5 * projectorGap),
      )
      ..relativeLineTo(-projectorGap, 0)
      ..addOval(Rect.fromCircle(center: offset, radius: bigCircleSize));
  }

  double get projectorWidth => realSize * kProjectorWidth;
  double get projectorHeight => realSize * kProjectorHeight;
  double get projectorGap => realSize * kProjectorGap;
  double get smallCircleSize => realSize * kSmallCircleSize;
  double get bigCircleSize => realSize * kBigCircleSize;

  @override
  void paint(Canvas canvas) {
    canvas.drawPath(_path, strokeStyle);
  }
}
