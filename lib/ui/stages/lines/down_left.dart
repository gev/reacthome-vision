import 'package:studio/ui/stages/line.dart';

class DownLeft extends Line {
  DownLeft({
    required super.start,
    required super.end,
    required super.radius,
    required super.style,
  });

  @override
  void toRightDown(double dx, double dy) {
    moveTo(start.dx, start.dy + radius);
    if (dx > 2 * radius && dy > 2 * radius) {
      lineToDown(dy - 2 * radius);
      arcToDownRight();
      lineToRight(dx - 2 * radius);
    } else if (dx > 4 * radius) {
      lineToDown(dy);
      arcToDownRight();
      lineToRight(dx / 2 - 2 * radius);
      arcToRightUp();
      arcToUpRight();
      lineToRight(dx / 2 - 2 * radius);
    } else if (dy > 4 * radius) {
      lineToDown(dy / 2 - 2 * radius);
      arcToDownLeft();
      arcToLeftDown();
      lineToDown(dy / 2 - 2 * radius);
      arcToDownRight();
      lineToRight(dx);
    } else {
      lineToDown(dy);
      arcToDownLeft();
      arcToLeftUp();
      arcToUpRight();
      lineToRight(dx);
    }
  }

  @override
  void toRightUp(double dx, double dy) {
    moveTo(start.dx, start.dy + radius);
    if (dx > 4 * radius) {
      arcToDownRight();
      lineToRight(dx / 2 - 2 * radius);
      arcToRightUp();
      lineToUp(dy);
      arcToUpRight();
      lineToRight(dx / 2 - 2 * radius);
    } else {
      arcToDownLeft();
      arcToLeftUp();
      lineToUp(dy);
      arcToUpRight();
      lineToRight(dx);
    }
  }

  @override
  void toLeftDown(double dx, double dy) {
    moveTo(start.dx, start.dy + radius);
    if (dy > 4 * radius) {
      lineToDown(dy / 2 - 2 * radius);
      arcToDownLeft();
      lineToLeft(dx);
      arcToLeftDown();
      lineToDown(dy / 2 - 2 * radius);
      arcToDownRight();
    } else {
      lineToDown(dy);
      arcToDownLeft();
      lineToLeft(dx);
      arcToLeftUp();
      arcToUpRight();
    }
  }

  @override
  void toLeftUp(double dx, double dy) {
    moveTo(start.dx, start.dy + radius);
    arcToDownLeft();
    lineToLeft(dx);
    arcToLeftUp();
    lineToUp(dy);
    arcToUpRight();
  }
}
