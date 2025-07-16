import 'package:studio/ui/stages/line.dart';

class RightLeft extends Line {
  RightLeft({
    required super.start,
    required super.end,
    required super.radius,
    required super.style,
  });

  @override
  void toRightDown(double dx, double dy) {
    moveTo(start.dx + radius, start.dy);
    if (dx > 2 * radius && dy == 0) {
      lineToRight(dx - 2 * radius);
    } else if (dx > 4 * radius && dy > 2 * radius) {
      lineToRight(dx / 2 - 2 * radius);
      arcToRightDown();
      lineToDown(dy - 2 * radius);
      arcToDownRight();
      lineToRight(dx / 2 - 2 * radius);
    } else if (dx > 6 * radius) {
      lineToRight(dx / 3 - 2 * radius);
      arcToRightDown();
      lineToDown(dy);
      arcToDownRight();
      lineToRight(dx / 3 - 2 * radius);
      arcToRightUp();
      arcToUpRight();
      lineToRight(dx / 3 - 2 * radius);
    } else if (dy > 4 * radius) {
      arcToRightDown();
      lineToDown(dy / 2 - 2 * radius);
      arcToDownLeft();
      lineToLeft(2 * radius - dx / 2);
      arcToLeftDown();
      lineToDown(dy / 2 - 2 * radius);
      arcToDownRight();
      lineToRight(dx / 2);
    } else {
      lineToRight(dx);
      arcToRightDown();
      lineToDown(dy);
      arcToDownLeft();
      lineToLeft(2 * radius);
      arcToLeftUp();
      arcToUpRight();
    }
  }

  @override
  void toRightUp(double dx, double dy) {
    moveTo(start.dx + radius, start.dy);
    if (dx > 2 * radius && dy == 0) {
      lineToRight(dx - 2 * radius);
    } else if (dx > 4 * radius && dy > 2 * radius) {
      lineToRight(dx / 2 - 2 * radius);
      arcToRightUp();
      lineToUp(dy - 2 * radius);
      arcToUpRight();
      lineToRight(dx / 2 - 2 * radius);
    } else if (dx > 6 * radius) {
      lineToRight(dx / 3 - 2 * radius);
      arcToRightUp();
      lineToUp(dy);
      arcToUpRight();
      lineToRight(dx / 3 - 2 * radius);
      arcToRightDown();
      arcToDownRight();
      lineToRight(dx / 3 - 2 * radius);
    } else if (dy > 4 * radius) {
      arcToRightUp();
      lineToUp(dy / 2 - 2 * radius);
      arcToUpLeft();
      lineToLeft(2 * radius - dx / 2);
      arcToLeftUp();
      lineToUp(dy / 2 - 2 * radius);
      arcToUpRight();
      lineToRight(dx / 2);
    } else {
      lineToRight(dx);
      arcToRightUp();
      lineToUp(dy);
      arcToUpLeft();
      lineToLeft(2 * radius);
      arcToLeftDown();
      arcToDownRight();
    }
  }

  @override
  void toLeftDown(double dx, double dy) {
    moveTo(start.dx + radius, start.dy);
    if (dy > 4 * radius) {
      arcToRightDown();
      lineToDown(dy / 2 - 2 * radius);
      arcToDownLeft();
      lineToLeft(dx + 2 * radius);
      arcToLeftDown();
      lineToDown(dy / 2 - 2 * radius);
      arcToDownRight();
    } else {
      arcToRightDown();
      lineToDown(dy);
      arcToDownLeft();
      lineToLeft(dx + 2 * radius);
      arcToLeftUp();
      arcToUpRight();
    }
  }

  @override
  void toLeftUp(double dx, double dy) {
    moveTo(start.dx + radius, start.dy);
    if (dy > 4 * radius) {
      arcToRightUp();
      lineToUp(dy / 2 - 2 * radius);
      arcToUpLeft();
      lineToLeft(dx + 2 * radius);
      arcToLeftUp();
      lineToUp(dy / 2 - 2 * radius);
      arcToUpRight();
    } else {
      arcToRightUp();
      lineToUp(dy);
      arcToUpLeft();
      lineToLeft(dx + 2 * radius);
      arcToLeftDown();
      arcToDownRight();
    }
  }
}
