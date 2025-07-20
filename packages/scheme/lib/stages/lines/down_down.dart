import '../line.dart';

class DownUp extends Line {
  DownUp({
    required super.start,
    required super.end,
    required super.radius,
    required super.style,
  });

  @override
  void toRightDown(double dx, double dy) {
    moveTo(start.dx, start.dy + radius);
    if (dx == 0 && dy > 2 * radius) {
      lineToDown(dy - 2 * radius);
    } else if (dx > 2 * radius && dy > 4 * radius) {
      lineToDown(dy / 2 - 2 * radius);
      arcToDownRight();
      lineToRight(dx - 2 * radius);
      arcToRightDown();
      lineToDown(dy / 2 - 2 * radius);
    } else if (dy > 6 * radius) {
      lineToDown(dy / 3 - 2 * radius);
      arcToDownLeft();
      arcToLeftDown();
      lineToDown(dy / 3 - 2 * radius);
      arcToDownRight();
      lineToRight(dx);
      arcToRightDown();
      lineToDown(dy / 3 - 2 * radius);
    } else if (dx > 4 * radius) {
      arcToDownRight();
      lineToRight(dx / 2 - 2 * radius);
      arcToRightUp();
      lineToUp(2 * radius - dy / 2);
      arcToUpRight();
      lineToRight(dx / 2 - 2 * radius);
      arcToRightDown();
      lineToDown(dy / 2);
    } else {
      lineToDown(dy);
      arcToDownRight();
      lineToRight(dx);
      arcToRightUp();
      lineToUp(2 * radius);
      arcToUpLeft();
      arcToLeftDown();
    }
  }

  @override
  void toRightUp(double dx, double dy) {
    moveTo(start.dx, start.dy + radius);
    if (dx > 4 * radius) {
      arcToDownRight();
      lineToRight(dx / 2 - 2 * radius);
      arcToRightUp();
      lineToUp(dy + 2 * radius);
      arcToUpRight();
      lineToRight(dx / 2 - 2 * radius);
      arcToRightDown();
    } else {
      arcToDownLeft();
      arcToLeftUp();
      lineToUp(dy + 2 * radius);
      arcToUpRight();
      lineToRight(dx);
      arcToRightDown();
    }
  }

  @override
  void toLeftDown(double dx, double dy) {
    moveTo(start.dx, start.dy + radius);
    if (dx == 0 && dy > 2 * radius) {
      lineToDown(dy - 2 * radius);
    } else if (dx > 2 * radius && dy > 4 * radius) {
      lineToDown(dy / 2 - 2 * radius);
      arcToDownLeft();
      lineToLeft(dx - 2 * radius);
      arcToLeftDown();
      lineToDown(dy / 2 - 2 * radius);
    } else if (dy > 6 * radius) {
      lineToDown(dy / 3 - 2 * radius);
      arcToDownRight();
      arcToRightDown();
      lineToDown(dy / 3 - 2 * radius);
      arcToDownLeft();
      lineToLeft(dx);
      arcToLeftDown();
      lineToDown(dy / 3 - 2 * radius);
    } else if (dx > 4 * radius) {
      arcToDownLeft();
      lineToLeft(dx / 2 - 2 * radius);
      arcToLeftUp();
      lineToUp(2 * radius - dy / 2);
      arcToUpLeft();
      lineToLeft(dx / 2 - 2 * radius);
      arcToLeftDown();
      lineToDown(dy / 2);
    } else {
      lineToDown(dy);
      arcToDownLeft();
      lineToLeft(dx);
      arcToLeftUp();
      lineToUp(2 * radius);
      arcToUpRight();
      arcToRightDown();
    }
  }

  @override
  void toLeftUp(double dx, double dy) {
    moveTo(start.dx, start.dy + radius);
    if (dx > 4 * radius) {
      arcToDownLeft();
      lineToLeft(dx / 2 - 2 * radius);
      arcToLeftUp();
      lineToUp(dy + 2 * radius);
      arcToUpLeft();
      lineToLeft(dx / 2 - 2 * radius);
      arcToLeftDown();
    } else {
      arcToDownRight();
      arcToRightUp();
      lineToUp(dy + 2 * radius);
      arcToUpLeft();
      lineToLeft(dx);
      arcToLeftDown();
    }
  }
}
