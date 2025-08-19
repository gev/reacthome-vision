import 'dart:ui';

import 'package:ui_kit/figures/figure.dart';

abstract class Line implements Paintable {
  final Offset start;
  final Offset end;
  final double radius;
  final LineStyle style;

  final Path _path = Path();

  Line({
    required this.start,
    required this.end,
    required this.radius,
    required this.style,
  }) {
    if (end.dx > start.dx) {
      if (end.dy > start.dy) {
        toRightDown(end.dx - start.dx, end.dy - start.dy);
      } else {
        toRightUp(end.dx - start.dx, start.dy - end.dy);
      }
    } else {
      if (end.dy > start.dy) {
        toLeftDown(start.dx - end.dx, end.dy - start.dy);
      } else {
        toLeftUp(start.dx - end.dx, start.dy - end.dy);
      }
    }
  }

  @override
  void paint(Canvas canvas) {
    canvas.drawPath(_path, style.back);
    canvas.drawPath(_path, style.stroke);
  }

  void toRightDown(double dx, double dy) {
    moveTo(start.dx, start.dy);
    lineToRight(dx);
    lineToDown(dy);
  }

  void toRightUp(double dx, double dy) {
    moveTo(start.dx, start.dy);
    lineToRight(dx);
    lineToUp(dy);
  }

  void toLeftDown(double dx, double dy) {
    moveTo(start.dx, start.dy);
    lineToLeft(dx);
    lineToDown(dy);
  }

  void toLeftUp(double dx, double dy) {
    moveTo(start.dx, start.dy);
    lineToLeft(dx);
    lineToUp(dy);
  }

  void moveTo(double dx, double dy) {
    _path.moveTo(dx, dy);
  }

  void lineToLeft(double dx) {
    _path.relativeLineTo(-dx, 0);
  }

  void lineToUp(double dy) {
    _path.relativeLineTo(0, -dy);
  }

  void lineToRight(double dx) {
    _path.relativeLineTo(dx, 0);
  }

  void lineToDown(double dy) {
    _path.relativeLineTo(0, dy);
  }

  void arcToLeftUp() {
    _arc(-radius, -radius, true);
  }

  void arcToLeftDown() {
    _arc(-radius, radius, false);
  }

  void arcToUpLeft() {
    _arc(-radius, -radius, false);
  }

  void arcToUpRight() {
    _arc(radius, -radius, true);
  }

  void arcToRightUp() {
    _arc(radius, -radius, false);
  }

  void arcToRightDown() {
    _arc(radius, radius, true);
  }

  void arcToDownLeft() {
    _arc(-radius, radius, true);
  }

  void arcToDownRight() {
    _arc(radius, radius, false);
  }

  void _arc(double dx, double dy, bool clockwise) {
    _path.relativeArcToPoint(
      Offset(dx, dy),
      radius: Radius.circular(radius),
      clockwise: clockwise,
    );
  }
}

class LineStyle {
  final Paint stroke;
  final Paint back;

  LineStyle({
    required Color color,
    required Color backgroundColor,
    double strokeWidth = 1.0,
    double sigma = 3,
  }) : stroke = Paint()
         ..style = PaintingStyle.stroke
         ..color = color
         ..strokeWidth = strokeWidth
         ..strokeCap = StrokeCap.round
         ..strokeJoin = StrokeJoin.round,
       back = Paint()
         ..style = PaintingStyle.stroke
         ..color = backgroundColor
         ..strokeWidth = 2 * sigma
         ..strokeCap = StrokeCap.round
         ..strokeJoin = StrokeJoin.round;
  //  ..imageFilter = ImageFilter.blur(sigmaX: sigma, sigmaY: sigma);
}
