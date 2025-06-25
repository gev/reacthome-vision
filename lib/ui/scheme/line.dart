import 'package:flutter/widgets.dart';
import 'package:studio/ui/figures/figure.dart';
import 'package:studio/ui/scheme/position.dart';

class Line implements Paintable {
  Line({required this.start, required this.end, required this.style});

  final Position start;
  final Position end;
  final LineStyle style;

  @override
  void paint(Canvas canvas) {
    canvas.drawLine(start.position, end.position, style.stroke);
  }
}

class LineStyle {
  final Paint stroke;

  LineStyle({required Color color, double strokeWidth = 1.0})
    : stroke = Paint()
        ..color = color
        ..strokeWidth = strokeWidth
        ..style = PaintingStyle.stroke;
}
