import 'dart:math';

import 'package:flutter/widgets.dart';
import 'package:studio/ui/figures/figure.dart';
import 'package:studio/ui/scheme/position.dart';

enum DirectionType { left, up, right, down, any }

typedef Anchor = ({DirectionType direction, Position point});

class Line implements Paintable {
  Line({
    this.radius = 24,
    required this.start,
    required this.end,
    required this.style,
  });

  final Anchor start;
  final Anchor end;
  final double radius;
  final LineStyle style;

  @override
  void paint(Canvas canvas) {
    if (end.point.position.dx < start.point.position.dx &&
        end.point.position.dy > start.point.position.dy) {
      _paintLT(canvas);
    } else if (end.point.position.dx > start.point.position.dx &&
        end.point.position.dy > start.point.position.dy) {
      _paintTR(canvas);
    } else if (end.point.position.dx > start.point.position.dx &&
        end.point.position.dy < start.point.position.dy) {
      _paintRB(canvas);
    } else if (end.point.position.dy < start.point.position.dy &&
        end.point.position.dx < start.point.position.dx) {
      _paintBL(canvas);
    } else {
      canvas.drawLine(start.point.position, end.point.position, style.stroke);
    }
  }

  void _paintLT(Canvas canvas) {
    final rx = min(radius, start.point.position.dx - end.point.position.dx);
    final ry = min(radius, end.point.position.dy - start.point.position.dy);
    final ax = Offset(end.point.position.dx + rx, start.point.position.dy);
    final ay = Offset(end.point.position.dx, start.point.position.dy + ry);
    final o = Offset(end.point.position.dx + rx, start.point.position.dy + ry);
    canvas.drawLine(start.point.position, ax, style.stroke);
    canvas.drawLine(ay, end.point.position, style.stroke);
    canvas.drawArc(
      Rect.fromCenter(center: o, width: 2 * rx, height: 2 * ry),
      pi,
      pi / 2,
      false,
      style.stroke,
    );
  }

  void _paintTR(Canvas canvas) {
    final rx = min(radius, end.point.position.dx - start.point.position.dx);
    final ry = min(radius, end.point.position.dy - start.point.position.dy);
    final ax = Offset(end.point.position.dx - rx, start.point.position.dy);
    final ay = Offset(end.point.position.dx, start.point.position.dy + ry);
    final o = Offset(end.point.position.dx - rx, start.point.position.dy + ry);
    canvas.drawLine(start.point.position, ax, style.stroke);
    canvas.drawLine(ay, end.point.position, style.stroke);
    canvas.drawArc(
      Rect.fromCenter(center: o, width: 2 * rx, height: 2 * ry),
      -pi / 2,
      pi / 2,
      false,
      style.stroke,
    );
  }

  void _paintRB(Canvas canvas) {
    final rx = min(radius, end.point.position.dx - start.point.position.dx);
    final ry = min(radius, start.point.position.dy - end.point.position.dy);
    final ax = Offset(end.point.position.dx - rx, start.point.position.dy);
    final ay = Offset(end.point.position.dx, start.point.position.dy - ry);
    final o = Offset(end.point.position.dx - rx, start.point.position.dy - ry);
    canvas.drawLine(start.point.position, ax, style.stroke);
    canvas.drawLine(ay, end.point.position, style.stroke);
    canvas.drawArc(
      Rect.fromCenter(center: o, width: 2 * rx, height: 2 * ry),
      0,
      pi / 2,
      false,
      style.stroke,
    );
  }

  void _paintBL(Canvas canvas) {
    final rx = min(radius, start.point.position.dx - end.point.position.dx);
    final ry = min(radius, start.point.position.dy - end.point.position.dy);
    final ax = Offset(end.point.position.dx + rx, start.point.position.dy);
    final ay = Offset(end.point.position.dx, start.point.position.dy - ry);
    final o = Offset(end.point.position.dx + rx, start.point.position.dy - ry);
    canvas.drawLine(start.point.position, ax, style.stroke);
    canvas.drawLine(ay, end.point.position, style.stroke);
    canvas.drawArc(
      Rect.fromCenter(center: o, width: 2 * rx, height: 2 * ry),
      pi / 2,
      pi / 2,
      false,
      style.stroke,
    );
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
