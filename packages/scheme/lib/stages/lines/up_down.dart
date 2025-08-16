import 'package:scheme/stages/line.dart';

class UpDown extends Line {
  UpDown({
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
      lineToDown(dy + 2 * radius);
      arcToDownRight();
      lineToRight(dx / 2 - 2 * radius);
      arcToRightUp();
    } else {
      arcToUpLeft();
      arcToLeftDown();
      lineToDown(dy + 2 * radius);
      arcToDownRight();
      lineToRight(dx);
      arcToRightUp();
    }
  }

  @override
  void toRightUp(double dx, double dy) {
    moveTo(start.dx, start.dy - radius);
    if (dx == 0 && dy > 2 * radius) {
      lineToUp(dy - 2 * radius);
    } else if (dx > 2 * radius && dy > 4 * radius) {
      lineToUp(dy / 2 - 2 * radius);
      arcToUpRight();
      lineToRight(dx - 2 * radius);
      arcToRightUp();
      lineToUp(dy / 2 - 2 * radius);
    } else if (dy > 6 * radius) {
      lineToUp(dy / 3 - 2 * radius);
      arcToUpLeft();
      arcToLeftUp();
      lineToUp(dy / 3 - 2 * radius);
      arcToUpRight();
      lineToRight(dx);
      arcToRightUp();
      lineToUp(dy / 3 - 2 * radius);
    } else if (dx > 4 * radius) {
      arcToUpRight();
      lineToRight(dx / 2 - 2 * radius);
      arcToRightDown();
      lineToDown(2 * radius - dy / 2);
      arcToDownRight();
      lineToRight(dx / 2 - 2 * radius);
      arcToRightUp();
      lineToUp(dy / 2);
    } else {
      lineToUp(dy);
      arcToUpRight();
      lineToRight(dx);
      arcToRightDown();
      lineToDown(2 * radius);
      arcToDownLeft();
      arcToLeftUp();
    }
  }

  @override
  void toLeftDown(double dx, double dy) {
    moveTo(start.dx, start.dy - radius);
    if (dx > 4 * radius) {
      arcToUpLeft();
      lineToLeft(dx / 2 - 2 * radius);
      arcToLeftDown();
      lineToDown(dy + 2 * radius);
      arcToDownLeft();
      lineToLeft(dx / 2 - 2 * radius);
      arcToLeftUp();
    } else {
      arcToUpRight();
      arcToRightDown();
      lineToDown(dy + 2 * radius);
      arcToDownLeft();
      lineToLeft(dx);
      arcToLeftUp();
    }
  }

  @override
  void toLeftUp(double dx, double dy) {
    moveTo(start.dx, start.dy - radius);
    if (dx == 0 && dy > 2 * radius) {
      lineToUp(dy - 2 * radius);
    } else if (dx > 2 * radius && dy > 4 * radius) {
      lineToUp(dy / 2 - 2 * radius);
      arcToUpLeft();
      lineToLeft(dx - 2 * radius);
      arcToLeftUp();
      lineToUp(dy / 2 - 2 * radius);
    } else if (dy > 6 * radius) {
      lineToUp(dy / 3 - 2 * radius);
      arcToUpRight();
      arcToRightUp();
      lineToUp(dy / 3 - 2 * radius);
      arcToUpLeft();
      lineToLeft(dx);
      arcToLeftUp();
      lineToUp(dy / 3 - 2 * radius);
    } else if (dx > 4 * radius) {
      arcToUpLeft();
      lineToLeft(dx / 2 - 2 * radius);
      arcToLeftDown();
      lineToDown(2 * radius - dy / 2);
      arcToDownLeft();
      lineToLeft(dx / 2 - 2 * radius);
      arcToLeftUp();
      lineToUp(dy / 2);
    } else {
      lineToUp(dy);
      arcToUpLeft();
      lineToLeft(dx);
      arcToLeftDown();
      lineToDown(2 * radius);
      arcToDownRight();
      arcToRightUp();
    }
  }
}
