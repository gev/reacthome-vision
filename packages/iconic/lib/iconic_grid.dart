import 'dart:ui';

import 'package:iconic/iconic.dart';

class IconicGrid extends Iconic {
  IconicGrid({
    required super.offset,
    required super.size,
    required super.style,
  });

  @override
  void paint(Canvas canvas) {
    canvas.drawCircle(offset, size / 2, stroke);
    canvas.drawRect(
      Rect.fromCenter(center: offset, width: 0.9 * size, height: 0.6 * size),
      stroke,
    );
    canvas.drawRect(
      Rect.fromCenter(center: offset, width: 0.6 * size, height: 0.9 * size),
      stroke,
    );
    canvas.drawRect(
      Rect.fromCenter(center: offset, width: 0.8 * size, height: 0.8 * size),
      stroke,
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
