import 'package:scheme/stages/line.dart';

class LeftUp extends Line {
  LeftUp({
    required super.start,
    required super.end,
    required super.radius,
    required super.style,
  });

  @override
  void toRightDown(double dx, double dy) {
    moveTo(start.dx - radius, start.dy);
    if (dy > 4 * radius) {
      arcToLeftDown();
      lineToDown(dy / 2 - 2 * radius);
      arcToDownRight();
      lineToRight(dx);
      arcToRightDown();
      lineToDown(dy / 2 - 2 * radius);
    } else {
      arcToLeftUp();
      arcToUpRight();
      lineToRight(dx);
      arcToRightDown();
      lineToDown(dy);
    }
  }

  @override
  void toRightUp(double dx, double dy) {
    moveTo(start.dx - radius, start.dy);
    arcToLeftUp();
    lineToUp(dy);
    arcToUpRight();
    lineToRight(dx);
    arcToRightDown();
  }

  @override
  void toLeftDown(double dx, double dy) {
    moveTo(start.dx - radius, start.dy);
    if (dx > 2 * radius && dy > 2 * radius) {
      lineToLeft(dx - 2 * radius);
      arcToLeftDown();
      lineToDown(dy - 2 * radius);
    } else if (dx > 4 * radius) {
      lineToLeft(dx / 2 - 2 * radius);
      arcToLeftUp();
      arcToUpLeft();
      lineToLeft(dx / 2 - 2 * radius);
      arcToLeftDown();
      lineToDown(dy);
    } else if (dy > 4 * radius) {
      lineToLeft(dx);
      arcToLeftDown();
      lineToDown(dy / 2 - 2 * radius);
      arcToDownRight();
      arcToRightDown();
      lineToDown(dy / 2 - 2 * radius);
    } else {
      lineToLeft(dx);
      arcToLeftUp();
      arcToUpRight();
      arcToRightDown();
      lineToDown(dy);
    }
  }

  @override
  void toLeftUp(double dx, double dy) {
    moveTo(start.dx - radius, start.dy);
    if (dx > 4 * radius) {
      lineToLeft(dx / 2 - 2 * radius);
      arcToLeftUp();
      lineToUp(dy);
      arcToUpLeft();
      lineToLeft(dx / 2 - 2 * radius);
      arcToLeftDown();
    } else {
      lineToLeft(dx);
      arcToLeftUp();
      lineToUp(dy);
      arcToUpRight();
      arcToRightDown();
    }
  }
}
