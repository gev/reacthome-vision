import 'dart:ui';

import 'package:studio/ui/figures/iconic.dart';

const k_blinds_gap = 0.25;
const k_blinds_width = 0.6;

class BlindsIconic extends Iconic {
  final double blindsGap;
  final double blindsWidth;

  BlindsIconic({required super.size, required super.iconicStyle})
    : blindsGap = size * k_blinds_gap,
      blindsWidth = size * k_blinds_width;

  @override
  void paint(Canvas canvas, Offset offset) {
    canvas.drawLine(
      Offset(offset.dx - blindsWidth, offset.dy),
      Offset(offset.dx + blindsWidth, offset.dy),
      strokeStyle,
    );
    canvas.drawLine(
      Offset(offset.dx - blindsWidth, offset.dy - blindsGap),
      Offset(offset.dx + blindsWidth, offset.dy - blindsGap),
      strokeStyle,
    );
    canvas.drawLine(
      Offset(offset.dx - blindsWidth, offset.dy - blindsGap * 2),
      Offset(offset.dx + blindsWidth, offset.dy - blindsGap * 2),
      strokeStyle,
    );
    canvas.drawLine(
      Offset(offset.dx - blindsWidth, offset.dy + blindsGap),
      Offset(offset.dx + blindsWidth, offset.dy + blindsGap),
      strokeStyle,
    );
    canvas.drawLine(
      Offset(offset.dx - blindsWidth, offset.dy + blindsGap * 2),
      Offset(offset.dx + blindsWidth, offset.dy + blindsGap * 2),
      strokeStyle,
    );
  }
}
