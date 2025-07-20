import '../line.dart';

class UpAuto extends Line {
  UpAuto({
    required super.start,
    required super.end,
    required super.radius,
    required super.style,
  });

  @override
  void toRightDown(double dx, double dy) {
    moveTo(start.dx, start.dy - radius);
    if (dx > 2 * radius) {
      arcToUpRight();
      lineToRight(dx - 2 * radius);
      arcToRightDown();
      lineToDown(dy);
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
    if (dx == 0 && dy > 2 * radius) {
      lineToUp(dy - 2 * radius);
    } else if (dx > 2 * radius && dy > 2 * radius) {
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
    if (dx > 2 * radius) {
      arcToUpLeft();
      lineToLeft(dx - 2 * radius);
      arcToLeftDown();
      lineToDown(dy);
    } else {
      arcToUpRight();
      arcToRightDown();
      lineToDown(dy);
      arcToDownLeft();
      lineToLeft(dx);
    }
  }

  @override
  void toLeftUp(double dx, double dy) {
    moveTo(start.dx, start.dy - radius);
    if (dx == 0 && dy > 2 * radius) {
      lineToUp(dy - 2 * radius);
    } else if (dx > 2 * radius && dy > 2 * radius) {
      lineToUp(dy - 2 * radius);
      arcToUpLeft();
      lineToLeft(dx - 2 * radius);
    } else if (dx > 4 * radius) {
      lineToUp(dy);
      arcToUpLeft();
      lineToLeft(dx / 2 - 2 * radius);
      arcToLeftDown();
      arcToDownLeft();
      lineToLeft(dx / 2 - 2 * radius);
    } else if (dy > 4 * radius) {
      lineToUp(dy / 2 - 2 * radius);
      arcToUpRight();
      arcToRightUp();
      lineToUp(dy / 2 - 2 * radius);
      arcToUpLeft();
      lineToLeft(dx);
    } else {
      lineToUp(dy);
      arcToUpRight();
      arcToRightDown();
      arcToDownLeft();
      lineToLeft(dx);
    }
  }
}
