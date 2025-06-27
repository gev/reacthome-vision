import 'dart:math';

import 'package:flutter/widgets.dart';
import 'package:studio/ui/figures/figure.dart';
import 'package:studio/ui/scheme/position.dart';

class Line implements Paintable {
  Line({
    this.radius = 24,
    required this.start,
    required this.end,
    required this.style,
  });

  final Position start;
  final Position end;
  final double radius;
  final LineStyle style;

  @override
  void paint(Canvas canvas) {
    if (end.position.dx < start.position.dx &&
        end.position.dy > start.position.dy) {
      _paintLT(canvas);
    } else if (end.position.dx > start.position.dx &&
        end.position.dy > start.position.dy) {
      _paintTR(canvas);
    } else if (end.position.dx > start.position.dx &&
        end.position.dy < start.position.dy) {
      _paintRB(canvas);
    } else if (end.position.dy < start.position.dy &&
        end.position.dx < start.position.dx) {
      _paintBL(canvas);
    } else {
      canvas.drawLine(start.position, end.position, style.stroke);
    }
  }

  void _paintLT(Canvas canvas) {
    final rx = min(radius, start.position.dx - end.position.dx);
    final ry = min(radius, end.position.dy - start.position.dy);
    final ax = Offset(end.position.dx + rx, start.position.dy);
    final ay = Offset(end.position.dx, start.position.dy + ry);
    canvas.drawLine(start.position, ax, style.stroke);
    canvas.drawLine(ay, end.position, style.stroke);
    final a = Offset(end.position.dx, start.position.dy);
    final b = Offset(end.position.dx + 2 * rx, start.position.dy + 2 * ry);
    canvas.drawArc(Rect.fromPoints(a, b), pi, pi / 2, false, style.stroke);
  }

  void _paintTR(Canvas canvas) {
    final rx = min(radius, end.position.dx - start.position.dx);
    final ry = min(radius, end.position.dy - start.position.dy);
    final ax = Offset(end.position.dx - rx, start.position.dy);
    final ay = Offset(end.position.dx, start.position.dy + ry);
    canvas.drawLine(start.position, ax, style.stroke);
    canvas.drawLine(ay, end.position, style.stroke);
    final a = Offset(end.position.dx - 2 * rx, start.position.dy);
    final b = Offset(end.position.dx, start.position.dy + 2 * ry);
    canvas.drawArc(Rect.fromPoints(a, b), -pi / 2, pi / 2, false, style.stroke);
  }

  void _paintRB(Canvas canvas) {
    final rx = min(radius, end.position.dx - start.position.dx);
    final ry = min(radius, start.position.dy - end.position.dy);
    final ax = Offset(end.position.dx - rx, start.position.dy);
    final ay = Offset(end.position.dx, start.position.dy - ry);
    canvas.drawLine(start.position, ax, style.stroke);
    canvas.drawLine(ay, end.position, style.stroke);
    final a = Offset(end.position.dx - 2 * rx, start.position.dy);
    final b = Offset(end.position.dx, start.position.dy - 2 * ry);
    canvas.drawArc(Rect.fromPoints(a, b), 0, pi / 2, false, style.stroke);
  }

  void _paintBL(Canvas canvas) {
    final rx = min(radius, start.position.dx - end.position.dx);
    final ry = min(radius, start.position.dy - end.position.dy);
    final ax = Offset(end.position.dx + rx, start.position.dy);
    final ay = Offset(end.position.dx, start.position.dy - ry);
    canvas.drawLine(start.position, ax, style.stroke);
    canvas.drawLine(ay, end.position, style.stroke);
    final a = Offset(end.position.dx, start.position.dy - 2 * ry);
    final b = Offset(end.position.dx + 2 * rx, start.position.dy);
    canvas.drawArc(Rect.fromPoints(a, b), pi / 2, pi / 2, false, style.stroke);
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
