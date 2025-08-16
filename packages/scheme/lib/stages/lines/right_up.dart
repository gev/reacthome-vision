import 'package:scheme/stages/line.dart';

class RightUp extends Line {
  RightUp({
    required super.start,
    required super.end,
    required super.radius,
    required super.style,
  });

  @override
  void toRightDown(double dx, double dy) {
    moveTo(start.dx + radius, start.dy);
    if (dx > 2 * radius && dy > 2 * radius) {
      lineToRight(dx - 2 * radius);
      arcToRightDown();
      lineToDown(dy - 2 * radius);
    } else if (dx > 4 * radius) {
      lineToRight(dx / 2 - 2 * radius);
      arcToRightUp();
      arcToUpRight();
      lineToRight(dx / 2 - 2 * radius);
      arcToRightDown();
      lineToDown(dy);
    } else if (dy > 4 * radius) {
      lineToRight(dx);
      arcToRightDown();
      lineToDown(dy / 2 - 2 * radius);
      arcToDownLeft();
      arcToLeftDown();
      lineToDown(dy / 2 - 2 * radius);
    } else {
      lineToRight(dx);
      arcToRightUp();
      arcToUpLeft();
      arcToLeftDown();
      lineToDown(dy);
    }
  }

  @override
  void toRightUp(double dx, double dy) {
    moveTo(start.dx + radius, start.dy);
    if (dx > 4 * radius) {
      lineToRight(dx / 2 - 2 * radius);
      arcToRightUp();
      lineToUp(dy);
      arcToUpRight();
      lineToRight(dx / 2 - 2 * radius);
      arcToRightDown();
    } else {
      lineToRight(dx);
      arcToRightUp();
      lineToUp(dy);
      arcToUpLeft();
      arcToLeftDown();
    }
  }

  @override
  void toLeftDown(double dx, double dy) {
    moveTo(start.dx + radius, start.dy);
    if (dy > 4 * radius) {
      arcToRightDown();
      lineToDown(dy / 2 - 2 * radius);
      arcToDownLeft();
      lineToLeft(dx);
      arcToLeftDown();
      lineToDown(dy / 2 - 2 * radius);
    } else {
      arcToRightUp();
      arcToUpLeft();
      lineToLeft(dx);
      arcToLeftDown();
      lineToDown(dy);
    }
  }

  @override
  void toLeftUp(double dx, double dy) {
    moveTo(start.dx + radius, start.dy);
    arcToRightUp();
    lineToUp(dy);
    arcToUpLeft();
    lineToLeft(dx);
    arcToLeftDown();
  }
}
