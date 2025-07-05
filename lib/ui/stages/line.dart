import 'dart:math';
import 'dart:ui';

import 'package:studio/ui/figures/figure.dart';

enum DirectionType { left, up, right, down, any }

typedef Anchor = ({DirectionType direction, Offset offset});

class Line implements Paintable {
  Line({this.radius = 24, required this.start, required this.end, required this.style}) {
    _path.moveTo(start.offset.dx, start.offset.dy);
    if (end.offset.dx < start.offset.dx && end.offset.dy > start.offset.dy) {
      _lt();
    } else if (end.offset.dx > start.offset.dx && end.offset.dy > start.offset.dy) {
      _tr();
    } else if (end.offset.dx > start.offset.dx && end.offset.dy < start.offset.dy) {
      _rb();
    } else if (end.offset.dy < start.offset.dy && end.offset.dx < start.offset.dx) {
      _bl();
    }
    _path.lineTo(end.offset.dx, end.offset.dy);
  }

  final Path _path = Path();

  final Anchor start;
  final Anchor end;
  final double radius;
  final LineStyle style;

  @override
  void paint(Canvas canvas) {
    canvas.drawPath(_path, style.back);
    canvas.drawPath(_path, style.stroke);
  }

  void _lt() {
    final dx = start.offset.dx - end.offset.dx;
    final dy = end.offset.dy - start.offset.dy;
    final rx = min(radius, dx);
    final ry = min(radius, dy);
    _path.relativeLineTo(rx - dx, 0);
    _path.relativeArcToPoint(Offset(-rx, ry), radius: Radius.elliptical(rx, ry), clockwise: false);
  }

  void _tr() {
    final dx = end.offset.dx - start.offset.dx;
    final dy = end.offset.dy - start.offset.dy;
    final rx = min(radius, dx);
    final ry = min(radius, dy);
    _path.relativeLineTo(dx - rx, 0);
    _path.relativeArcToPoint(Offset(rx, ry), radius: Radius.elliptical(rx, ry));
  }

  void _rb() {
    final dx = end.offset.dx - start.offset.dx;
    final dy = start.offset.dy - end.offset.dy;
    final rx = min(radius, dx);
    final ry = min(radius, dy);
    _path.relativeLineTo(dx - rx, 0);
    _path.relativeArcToPoint(Offset(rx, -ry), radius: Radius.elliptical(rx, ry), clockwise: false);
  }

  void _bl() {
    final dx = start.offset.dx - end.offset.dx;
    final dy = start.offset.dy - end.offset.dy;
    final rx = min(radius, dx);
    final ry = min(radius, dy);
    _path.relativeLineTo(rx - dx, 0);
    _path.relativeArcToPoint(Offset(-rx, -ry), radius: Radius.elliptical(rx, ry));
  }
}

class LineStyle {
  final Paint stroke;
  final Paint back;

  LineStyle({
    required Color color,
    required Color backgroundColor,
    double strokeWidth = 1.0,
    double sigma = 8,
  }) : stroke = Paint()
         ..style = PaintingStyle.stroke
         ..color = color
         ..strokeWidth = strokeWidth,
       back = Paint()
         ..style = PaintingStyle.stroke
         ..color = backgroundColor
         ..strokeWidth = 2 * sigma
         ..imageFilter = ImageFilter.blur(sigmaX: sigma, sigmaY: sigma);
}
