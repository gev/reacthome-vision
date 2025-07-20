import 'dart:ui';

import 'package:studio/ui/figures/figure.dart';

class IconicGrid implements Paintable {
  final Offset offset;
  final double size;
  final IconicGridStyle style;

  IconicGrid({required this.offset, required this.size, required this.style});

  @override
  void paint(Canvas canvas) {
    canvas.drawCircle(offset, size / 2, style.stroke);
    canvas.drawRect(
      Rect.fromCenter(center: offset, width: 0.9 * size, height: 0.6 * size),
      style.stroke,
    );
    canvas.drawRect(
      Rect.fromCenter(center: offset, width: 0.6 * size, height: 0.9 * size),
      style.stroke,
    );
    canvas.drawRect(
      Rect.fromCenter(center: offset, width: 0.8 * size, height: 0.8 * size),
      style.stroke,
    );
  }
}

class IconicGridStyle {
  IconicGridStyle({required Color color, double width = 0.2})
    : stroke = Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = width
        ..color = color;

  final Paint stroke;
}
