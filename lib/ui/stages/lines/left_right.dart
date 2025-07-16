import 'package:studio/ui/stages/line.dart';

class LeftRight extends Line {
  LeftRight({
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
      lineToRight(dx + 2 * radius);
      arcToRightDown();
      lineToDown(dy / 2 - 2 * radius);
      arcToDownLeft();
    } else {
      arcToLeftDown();
      lineToDown(dy);
      arcToDownRight();
      lineToRight(dx + 2 * radius);
      arcToRightUp();
      arcToUpLeft();
    }
  }

  @override
  void toRightUp(double dx, double dy) {
    moveTo(start.dx - radius, start.dy);
    if (dy > 4 * radius) {
      arcToLeftUp();
      lineToUp(dy / 2 - 2 * radius);
      arcToUpRight();
      lineToRight(dx + 2 * radius);
      arcToRightUp();
      lineToUp(dy / 2 - 2 * radius);
      arcToUpLeft();
    } else {
      arcToLeftUp();
      lineToUp(dy);
      arcToUpRight();
      lineToRight(dx + 2 * radius);
      arcToRightDown();
      arcToDownLeft();
    }
  }

  @override
  void toLeftDown(double dx, double dy) {
    moveTo(start.dx - radius, start.dy);
    if (dx > 2 * radius && dy == 0) {
      lineToLeft(dx - 2 * radius);
    } else if (dx > 4 * radius && dy > 2 * radius) {
      lineToLeft(dx / 2 - 2 * radius);
      arcToLeftDown();
      lineToDown(dy - 2 * radius);
      arcToDownLeft();
      lineToLeft(dx / 2 - 2 * radius);
    } else if (dx > 6 * radius) {
      lineToLeft(dx / 3 - 2 * radius);
      arcToLeftDown();
      lineToDown(dy);
      arcToDownLeft();
      lineToLeft(dx / 3 - 2 * radius);
      arcToLeftUp();
      arcToUpLeft();
      lineToLeft(dx / 3 - 2 * radius);
    } else if (dy > 4 * radius) {
      arcToLeftDown();
      lineToDown(dy / 2 - 2 * radius);
      arcToDownRight();
      lineToRight(2 * radius - dx / 2);
      arcToRightDown();
      lineToDown(dy / 2 - 2 * radius);
      arcToDownLeft();
      lineToLeft(dx / 2);
    } else {
      lineToLeft(dx);
      arcToLeftDown();
      lineToDown(dy);
      arcToDownRight();
      lineToRight(2 * radius);
      arcToRightUp();
      arcToUpLeft();
    }
  }

  @override
  void toLeftUp(double dx, double dy) {
    moveTo(start.dx - radius, start.dy);
    if (dx > 2 * radius && dy == 0) {
      lineToLeft(dx - 2 * radius);
    } else if (dx > 4 * radius && dy > 2 * radius) {
      lineToLeft(dx / 2 - 2 * radius);
      arcToLeftUp();
      lineToUp(dy - 2 * radius);
      arcToUpLeft();
      lineToLeft(dx / 2 - 2 * radius);
    } else if (dx > 6 * radius) {
      lineToLeft(dx / 3 - 2 * radius);
      arcToLeftUp();
      lineToUp(dy);
      arcToUpLeft();
      lineToLeft(dx / 3 - 2 * radius);
      arcToLeftDown();
      arcToDownLeft();
      lineToLeft(dx / 3 - 2 * radius);
    } else if (dy > 4 * radius) {
      arcToLeftUp();
      lineToUp(dy / 2 - 2 * radius);
      arcToUpRight();
      lineToRight(2 * radius - dx / 2);
      arcToRightUp();
      lineToUp(dy / 2 - 2 * radius);
      arcToUpLeft();
      lineToLeft(dx / 2);
    } else {
      lineToLeft(dx);
      arcToLeftUp();
      lineToUp(dy);
      arcToUpRight();
      lineToRight(2 * radius);
      arcToRightDown();
      arcToDownLeft();
    }
  }
}
