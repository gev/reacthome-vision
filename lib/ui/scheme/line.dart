import 'package:flutter/widgets.dart';
import 'package:studio/ui/figures/figure.dart';
import 'package:studio/ui/scheme/vertex.dart';

class Line implements Figure {
  Line({required this.start, required this.end, required this.style});

  final Vertex start;
  final Vertex end;
  final LineStyle style;

  @override
  void paint(Canvas canvas) {
    canvas.drawLine(start.position, end.position, style.stroke);
  }

  @override
  bool hitTest(Offset position) {
    // Implement hit test logic for the line
    return false;
  }
}

class LineStyle {
  final Paint _stroke;

  Paint get stroke => _stroke;

  LineStyle({required Color color, double strokeWidth = 1.0})
    : _stroke = Paint()
        ..color = color
        ..strokeWidth = strokeWidth
        ..style = PaintingStyle.stroke;
}
