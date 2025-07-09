import 'package:flutter/widgets.dart';

abstract class LinePath {
  final Offset start;
  final Offset end;
  final double radius;

  final Path path = Path();

  LinePath({required this.start, required this.end, required this.radius}) {
    path.moveTo(start.dx, start.dy);
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
    path.lineTo(end.dx, end.dy);
  }

  void toRightDown(double dx, double dy) {
    lineToRight(dx - radius);
    arcToRightDown();
    lineToDown(dy - radius);
  }

  void toRightUp(double dx, double dy) {
    lineToRight(dx - radius);
    arcToRightUp();
    lineToUp(dy - radius);
  }

  void toLeftDown(double dx, double dy) {
    lineToLeft(dx - radius);
    arcToLeftDown();
    lineToDown(dy - radius);
  }

  void toLeftUp(double dx, double dy) {
    lineToLeft(dx - radius);
    arcToLeftUp();
    lineToUp(dy - radius);
  }

  void lineToLeft(double dx) {
    path.relativeLineTo(-dx, 0);
  }

  void lineToUp(double dy) {
    path.relativeLineTo(0, -dy);
  }

  void lineToRight(double dx) {
    path.relativeLineTo(dx, 0);
  }

  void lineToDown(double dy) {
    path.relativeLineTo(0, dy);
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
    path.relativeArcToPoint(
      Offset(dx, dy),
      radius: Radius.circular(radius),
      clockwise: clockwise,
    );
  }
}
