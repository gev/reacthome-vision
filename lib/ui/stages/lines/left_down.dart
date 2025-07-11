import 'package:studio/ui/stages/line.dart';

class LeftDown extends Line {
  LeftDown({
    required super.start,
    required super.end,
    required super.radius,
    required super.style,
  });

  @override
  void toRightDown(double dx, double dy) {
    moveTo(start.dx - radius, start.dy);
    arcToLeftDown();
    lineToDown(dy);
    arcToDownRight();
    lineToRight(dx);
    arcToRightUp();
  }

  @override
  void toRightUp(double dx, double dy) {
    moveTo(start.dx - radius, start.dy);
    if (dy > 4 * radius) {
      arcToLeftUp();
      lineToUp(dy / 2 - 2 * radius);
      arcToUpRight();
      lineToRight(dx);
      arcToRightUp();
      lineToUp(dy / 2 - 2 * radius);
    } else {
      arcToLeftDown();
      arcToDownRight();
      lineToRight(dx);
      arcToRightUp();
      lineToUp(dy);
    }
  }

  @override
  void toLeftDown(double dx, double dy) {
    moveTo(start.dx - radius, start.dy);
    if (dx > 4 * radius) {
      lineToLeft(dx / 2 - 2 * radius);
      arcToLeftDown();
      lineToDown(dy);
      arcToDownLeft();
      lineToLeft(dx / 2 - 2 * radius);
      arcToLeftUp();
    } else {
      lineToLeft(dx);
      arcToLeftDown();
      lineToDown(dy);
      arcToDownRight();
      arcToRightUp();
    }
  }

  @override
  void toLeftUp(double dx, double dy) {
    moveTo(start.dx - radius, start.dy);
    if (dx > 2 * radius && dy > 2 * radius) {
      lineToLeft(dx - 2 * radius);
      arcToLeftUp();
      lineToUp(dy - 2 * radius);
    } else if (dx > 4 * radius) {
      lineToLeft(dx / 2 - 2 * radius);
      arcToLeftDown();
      arcToDownLeft();
      lineToLeft(dx / 2 - 2 * radius);
      arcToLeftUp();
      lineToUp(dy);
    } else if (dy > 4 * radius) {
      lineToLeft(dx);
      arcToLeftUp();
      lineToUp(dy / 2 - 2 * radius);
      arcToUpRight();
      arcToRightUp();
      lineToUp(dy / 2 - 2 * radius);
    } else {
      lineToLeft(dx);
      arcToLeftDown();
      arcToDownRight();
      arcToRightUp();
      lineToUp(dy);
    }
  }
}
