import '../line.dart';

class UpRight extends Line {
  UpRight({
    required super.start,
    required super.end,
    required super.radius,
    required super.style,
  });

  @override
  void toRightDown(double dx, double dy) {
    moveTo(start.dx, start.dy - radius);
    arcToUpRight();
    lineToRight(dx);
    arcToRightDown();
    lineToDown(dy);
    arcToDownLeft();
  }

  @override
  void toRightUp(double dx, double dy) {
    moveTo(start.dx, start.dy - radius);
    if (dy > 4 * radius) {
      lineToUp(dy / 2 - 2 * radius);
      arcToUpRight();
      lineToRight(dx);
      arcToRightUp();
      lineToUp(dy / 2 - 2 * radius);
      arcToUpLeft();
    } else {
      lineToUp(dy);
      arcToUpRight();
      lineToRight(dx);
      arcToRightDown();
      arcToDownLeft();
    }
  }

  @override
  void toLeftDown(double dx, double dy) {
    moveTo(start.dx, start.dy - radius);
    if (dx > 4 * radius) {
      arcToUpLeft();
      lineToLeft(dx / 2 - 2 * radius);
      arcToLeftDown();
      lineToDown(dy);
      arcToDownLeft();
      lineToLeft(dx / 2 - 2 * radius);
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
    if (dx > 2 * radius && dy > 2 * radius) {
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
