import 'dart:math';
import 'dart:ui';

import 'package:studio/ui/figures/iconic.dart';

const k_heater_top = 0.6;
const k_heater_middle = 0.4;
const k_heater_bottom = 0.6;
const k_heater_gap = 0.4;
const k_top_arc = 0.5;
const k_bottom_arc = 0.5;

class HeaterIconic extends Iconic {
  final double heaterTop;
  final double heaterMiddle;
  final double heaterBottom;
  final double heaterGap;

  final Offset a = Offset(0, 0);
  final Offset b = Offset(0, 0);

  HeaterIconic({required super.size, required super.iconicStyle})
    : heaterGap = size * k_heater_gap,
      heaterTop = size * k_heater_top,
      heaterMiddle = size * k_heater_middle,
      heaterBottom = size * k_heater_bottom;

  @override
  void paint(Canvas canvas, Offset offset) {
    canvas.drawLine(
      Offset(offset.dx - heaterTop, offset.dy),
      Offset(offset.dx + heaterTop, offset.dy),
      strokeStyle,
    );
    canvas.drawArc(Rect.fromPoints(a, b), 0, pi / 2, false, strokeStyle);
    canvas.drawLine(
      Offset(offset.dx - heaterTop, offset.dy - heaterGap),
      Offset(offset.dx + heaterTop, offset.dy - heaterGap),
      strokeStyle,
    );
    canvas.drawLine(
      Offset(offset.dx - heaterTop, offset.dy + heaterGap),
      Offset(offset.dx + heaterTop, offset.dy + heaterGap),
      strokeStyle,
    );
  }
}
