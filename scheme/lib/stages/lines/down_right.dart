import '../line.dart';

class DownRight extends Line {
  DownRight({
    required super.start,
    required super.end,
    required super.radius,
    required super.style,
  });

  @override
  void toRightDown(double dx, double dy) {
    moveTo(start.dx, start.dy + radius);
    if (dy > 4 * radius) {
      lineToDown(dy / 2 - 2 * radius);
      arcToDownRight();
      lineToRight(dx);
      arcToRightDown();
      lineToDown(dy / 2 - 2 * radius);
      arcToDownLeft();
    } else {
      lineToDown(dy);
      arcToDownRight();
      lineToRight(dx);
      arcToRightUp();
      arcToUpLeft();
    }
  }

  @override
  void toRightUp(double dx, double dy) {
    moveTo(start.dx, start.dy + radius);
    arcToDownRight();
    lineToRight(dx);
    arcToRightUp();
    lineToUp(dy);
    arcToUpLeft();
  }

  @override
  void toLeftDown(double dx, double dy) {
    moveTo(start.dx, start.dy + radius);
    if (dx > 2 * radius && dy > 2 * radius) {
      lineToDown(dy - 2 * radius);
      arcToDownLeft();
      lineToLeft(dx - 2 * radius);
    } else if (dx > 4 * radius) {
      lineToDown(dy);
      arcToDownLeft();
      lineToLeft(dx / 2 - 2 * radius);
      arcToLeftUp();
      arcToUpLeft();
      lineToLeft(dx / 2 - 2 * radius);
    } else if (dy > 4 * radius) {
      lineToDown(dy / 2 - 2 * radius);
      arcToDownRight();
      arcToRightDown();
      lineToDown(dy / 2 - 2 * radius);
      arcToDownLeft();
      lineToLeft(dx);
    } else {
      lineToDown(dy);
      arcToDownRight();
      arcToRightUp();
      arcToUpLeft();
      lineToLeft(dx);
    }
  }

  @override
  void toLeftUp(double dx, double dy) {
    moveTo(start.dx, start.dy + radius);
    if (dx > 4 * radius) {
      arcToDownLeft();
      lineToLeft(dx / 2 - 2 * radius);
      arcToLeftUp();
      lineToUp(dy);
      arcToUpLeft();
      lineToLeft(dx / 2 - 2 * radius);
    } else {
      arcToDownRight();
      arcToRightUp();
      lineToUp(dy);
      arcToUpLeft();
      lineToLeft(dx);
    }
  }
}
