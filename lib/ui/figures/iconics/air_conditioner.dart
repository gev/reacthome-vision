import 'dart:ui';

import 'package:studio/ui/figures/iconic.dart';

const kConditionerWidth = 0.5;
const kConditionerHeight = 0.3;
const kConditionerGap = 0.08;
const kCircleSize = 0.08;

class AirConditionerIconic extends Iconic {
  final Path _path = Path();
  double get conditionerWidth => realSize * kConditionerWidth;
  double get conditionerHeight => realSize * kConditionerHeight;
  double get conditionerGap => realSize * kConditionerGap;
  double get circleSize => realSize * kCircleSize;
  AirConditionerIconic({
    required super.offset,
    required super.size,
    required super.iconicStyle,
  }) {
    _path
      ..moveTo(
        offset.dx - conditionerWidth,
        offset.dy + (conditionerHeight - conditionerGap),
      )
      ..relativeLineTo(2 * conditionerWidth, 0)
      ..relativeMoveTo(0, -conditionerGap)
      ..relativeLineTo(-2 * conditionerWidth, 0)
      ..addRect(
        Rect.fromPoints(
          Offset(offset.dx - conditionerWidth, offset.dy + conditionerHeight),
          Offset(offset.dx + conditionerWidth, offset.dy - conditionerHeight),
        ),
      )
      ..moveTo(offset.dx + (conditionerWidth - conditionerGap), offset.dy)
      ..addOval(
        Rect.fromCircle(
          center: Offset(
            offset.dx + (conditionerWidth - conditionerGap * 2),
            offset.dy,
          ),
          radius: circleSize,
        ),
      );
  }

  @override
  void paint(Canvas canvas) {
    canvas.drawPath(_path, strokeStyle);
  }
}
