import 'package:studio/ui/stages/line.dart';

class UpLeft extends Line {
  UpLeft({
    required super.start,
    required super.end,
    required super.radius,
    required super.style,
  });

  @override
  void toRightDown(double dx, double dy) {
    moveTo(start.dx, start.dy - radius);
    if (dx > 4 * radius) {
      arcToUpRight();
      lineToRight(dx / 2 - 2 * radius);
      arcToRightDown();
      lineToDown(dy);
      arcToDownRight();
      lineToRight(dx / 2 - 2 * radius);
    } else {
      arcToUpLeft();
      arcToLeftDown();
      lineToDown(dy);
      arcToDownRight();
      lineToRight(dx);
    }
  }

  @override
  void toRightUp(double dx, double dy) {
    moveTo(start.dx, start.dy - radius);
    if (dx > 2 * radius && dy > 2 * radius) {
      lineToUp(dy - 2 * radius);
      arcToUpRight();
      lineToRight(dx - 2 * radius);
    } else if (dx > 4 * radius) {
      lineToUp(dy);
      arcToUpRight();
      lineToRight(dx / 2 - 2 * radius);
      arcToRightDown();
      arcToDownRight();
      lineToRight(dx / 2 - 2 * radius);
    } else if (dy > 4 * radius) {
      lineToUp(dy / 2 - 2 * radius);
      arcToUpLeft();
      arcToLeftUp();
      lineToUp(dy / 2 - 2 * radius);
      arcToUpRight();
      lineToRight(dx);
    } else {
      lineToUp(dy);
      arcToUpLeft();
      arcToLeftDown();
      arcToDownRight();
      lineToRight(dx);
    }
  }

  @override
  void toLeftDown(double dx, double dy) {
    moveTo(start.dx, start.dy - radius);
    arcToUpLeft();
    lineToLeft(dx);
    arcToLeftDown();
    lineToDown(dy);
    arcToDownRight();
  }

  @override
  void toLeftUp(double dx, double dy) {
    moveTo(start.dx, start.dy - radius);
    if (dy > 4 * radius) {
      lineToUp(dy / 2 - 2 * radius);
      arcToUpLeft();
      lineToLeft(dx);
      arcToLeftUp();
      lineToUp(dy / 2 - 2 * radius);
      arcToUpRight();
    } else {
      lineToUp(dy);
      arcToUpLeft();
      lineToLeft(dx);
      arcToLeftDown();
      arcToDownRight();
    }
  }
}
