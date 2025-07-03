import 'dart:math';

import 'package:flutter/widgets.dart';
import 'package:studio/ui/figures/figure.dart';

enum DirectionType { left, up, right, down, any }

typedef Anchor = ({DirectionType direction, Offset offset});

class Line implements Paintable {
  Line({this.radius = 24, required this.start, required this.end, required this.style}) {
    if (end.offset.dx < start.offset.dx && end.offset.dy > start.offset.dy) {
      _lt();
    } else if (end.offset.dx > start.offset.dx && end.offset.dy > start.offset.dy) {
      _tr();
    } else if (end.offset.dx > start.offset.dx && end.offset.dy < start.offset.dy) {
      _rb();
    } else if (end.offset.dy < start.offset.dy && end.offset.dx < start.offset.dx) {
      _bl();
    } else {
      _l();
    }
  }

  final Path _path = Path();

  final Anchor start;
  final Anchor end;
  final double radius;
  final LineStyle style;

  @override
  void paint(Canvas canvas) {
    canvas.drawPath(_path, style.stroke);
  }

  void _l() {
    _path.moveTo(start.offset.dx, start.offset.dy);
    _path.lineTo(end.offset.dx, end.offset.dy);
  }

  void _lt() {
    final dx = start.offset.dx - end.offset.dx;
    final dy = end.offset.dy - start.offset.dy;
    final rx = min(radius, dx);
    final ry = min(radius, dy);
    _path.moveTo(end.offset.dx, end.offset.dy);
    _path.relativeLineTo(0, ry - dy);
    _path.relativeArcToPoint(Offset(rx, -ry), radius: Radius.elliptical(rx, ry));
    _path.lineTo(start.offset.dx, start.offset.dy);
  }

  void _tr() {
    final dx = end.offset.dx - start.offset.dx;
    final dy = end.offset.dy - start.offset.dy;
    final rx = min(radius, dx);
    final ry = min(radius, dy);
    _path.moveTo(start.offset.dx, start.offset.dy);
    _path.relativeLineTo(dx - rx, 0);
    _path.relativeArcToPoint(Offset(rx, ry), radius: Radius.elliptical(rx, ry));
    _path.lineTo(end.offset.dx, end.offset.dy);
  }

  void _rb() {
    final dx = end.offset.dx - start.offset.dx;
    final dy = start.offset.dy - end.offset.dy;
    final rx = min(radius, dx);
    final ry = min(radius, dy);
    _path.moveTo(end.offset.dx, end.offset.dy);
    _path.relativeLineTo(0, dy - ry);
    _path.relativeArcToPoint(Offset(-rx, ry), radius: Radius.elliptical(rx, ry));
    _path.lineTo(start.offset.dx, start.offset.dy);
  }

  void _bl() {
    final dx = start.offset.dx - end.offset.dx;
    final dy = start.offset.dy - end.offset.dy;
    final rx = min(radius, dx);
    final ry = min(radius, dy);
    _path.moveTo(start.offset.dx, start.offset.dy);
    _path.relativeLineTo(rx - dx, 0);
    _path.relativeArcToPoint(Offset(-rx, -ry), radius: Radius.elliptical(rx, ry));
    _path.lineTo(end.offset.dx, end.offset.dy);
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
