import '../line.dart';

class AutoDown extends Line {
  AutoDown({
    required super.start,
    required super.end,
    required super.radius,
    required super.style,
  });

  @override
  void toRightDown(double dx, double dy) {
    if (dx > 2 * radius) {
      moveTo(start.dx, start.dy + radius);
      lineToDown(dy);
      arcToDownRight();
      lineToRight(dx - 2 * radius);
      arcToRightUp();
    } else {
      moveTo(start.dx - radius, start.dy);
      arcToLeftDown();
      lineToDown(dy);
      arcToDownRight();
      lineToRight(dx);
      arcToRightUp();
    }
  }

  @override
  void toRightUp(double dx, double dy) {
    if (dx == 0 && dy > 2 * radius) {
      moveTo(start.dx, start.dy + radius);
      lineToUp(dy - 2 * radius);
    } else if (dx > 2 * radius && dy > 2 * radius) {
      moveTo(start.dx + radius, start.dy);
      lineToRight(dx - 2 * radius);
      arcToRightUp();
      lineToUp(dy - 2 * radius);
    } else if (dx > 2 * radius) {
      moveTo(start.dx, start.dy + radius);
      arcToDownRight();
      lineToRight(dx - 2 * radius);
      arcToRightUp();
      lineToUp(dy);
    } else if (dy > 6 * radius) {
      moveTo(start.dx, start.dy - radius);
      lineToUp(dy / 3 - 2 * radius);
      arcToUpLeft();
      arcToLeftUp();
      lineToUp(dy / 3 - 2 * radius);
      arcToUpRight();
      lineToRight(dx);
      arcToRightUp();
      lineToUp(dy / 3 - 2 * radius);
    } else if (dy > 4 * radius) {
      moveTo(start.dx - radius, start.dy);
      arcToLeftUp();
      lineToUp(dy / 2 - 2 * radius);
      arcToUpRight();
      lineToRight(dx);
      arcToRightUp();
      lineToUp(dy / 2 - 2 * radius);
    } else {
      moveTo(start.dx - radius, start.dy);
      arcToLeftDown();
      arcToDownRight();
      lineToRight(dx);
      arcToRightUp();
      lineToUp(dy);
    }
  }

  @override
  void toLeftDown(double dx, double dy) {
    if (dx > 2 * radius) {
      moveTo(start.dx, start.dy + radius);
      lineToDown(dy);
      arcToDownLeft();
      lineToLeft(dx - 2 * radius);
      arcToLeftUp();
    } else {
      moveTo(start.dx + radius, start.dy);
      arcToRightDown();
      lineToDown(dy);
      arcToDownLeft();
      lineToLeft(dx);
      arcToLeftUp();
    }
  }

  @override
  void toLeftUp(double dx, double dy) {
    if (dx == 0 && dy > 2 * radius) {
      moveTo(start.dx, start.dy - radius);
      lineToUp(dy - 2 * radius);
    } else if (dx > 2 * radius && dy > 2 * radius) {
      moveTo(start.dx - radius, start.dy);
      lineToLeft(dx - 2 * radius);
      arcToLeftUp();
      lineToUp(dy - 2 * radius);
    } else if (dx > 2 * radius) {
      moveTo(start.dx, start.dy + radius);
      arcToDownLeft();
      lineToLeft(dx - 2 * radius);
      arcToLeftUp();
      lineToUp(dy);
    } else if (dy > 6 * radius) {
      moveTo(start.dx, start.dy - radius);
      lineToUp(dy / 3 - 2 * radius);
      arcToUpRight();
      arcToRightUp();
      lineToUp(dy / 3 - 2 * radius);
      arcToUpLeft();
      lineToLeft(dx);
      arcToLeftUp();
      lineToUp(dy / 3 - 2 * radius);
    } else if (dy > 4 * radius) {
      moveTo(start.dx + radius, start.dy);
      arcToRightUp();
      lineToUp(dy / 2 - 2 * radius);
      arcToUpLeft();
      lineToLeft(dx);
      arcToLeftUp();
      lineToUp(dy / 2 - 2 * radius);
    } else {
      moveTo(start.dx + radius, start.dy);
      arcToRightDown();
      arcToDownLeft();
      lineToLeft(dx);
      arcToLeftUp();
      lineToUp(dy);
    }
  }
}
