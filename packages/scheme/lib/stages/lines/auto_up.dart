import 'package:scheme/stages/line.dart';

class AutoUp extends Line {
  AutoUp({
    required super.start,
    required super.end,
    required super.radius,
    required super.style,
  });

  @override
  void toRightDown(double dx, double dy) {
    if (dx == 0 && dy > 2 * radius) {
      moveTo(start.dx, start.dy - radius);
      lineToDown(dy - 2 * radius);
    } else if (dx > 2 * radius && dy > 2 * radius) {
      moveTo(start.dx + radius, start.dy);
      lineToRight(dx - 2 * radius);
      arcToRightDown();
      lineToDown(dy - 2 * radius);
    } else if (dx > 2 * radius) {
      moveTo(start.dx, start.dy - radius);
      arcToUpRight();
      lineToRight(dx - 2 * radius);
      arcToRightDown();
      lineToDown(dy);
    } else if (dy > 6 * radius) {
      moveTo(start.dx, start.dy + radius);
      lineToDown(dy / 3 - 2 * radius);
      arcToDownLeft();
      arcToLeftDown();
      lineToDown(dy / 3 - 2 * radius);
      arcToDownRight();
      lineToRight(dx);
      arcToRightDown();
      lineToDown(dy / 3 - 2 * radius);
    } else if (dy > 4 * radius) {
      moveTo(start.dx - radius, start.dy);
      arcToLeftDown();
      lineToDown(dy / 2 - 2 * radius);
      arcToDownRight();
      lineToRight(dx);
      arcToRightDown();
      lineToDown(dy / 2 - 2 * radius);
    } else {
      moveTo(start.dx - radius, start.dy);
      arcToLeftUp();
      arcToUpRight();
      lineToRight(dx);
      arcToRightDown();
      lineToDown(dy);
    }
  }

  @override
  void toRightUp(double dx, double dy) {
    if (dx > 2 * radius) {
      moveTo(start.dx, start.dy - radius);
      lineToUp(dy);
      arcToUpRight();
      lineToRight(dx - 2 * radius);
      arcToRightDown();
    } else {
      moveTo(start.dx - radius, start.dy);
      arcToLeftUp();
      lineToUp(dy);
      arcToUpRight();
      lineToRight(dx);
      arcToRightDown();
    }
  }

  @override
  void toLeftDown(double dx, double dy) {
    if (dx == 0 && dy > 2 * radius) {
      moveTo(start.dx, start.dy + radius);
      lineToDown(dy - 2 * radius);
    } else if (dx > 2 * radius && dy > 2 * radius) {
      moveTo(start.dx - radius, start.dy);
      lineToLeft(dx - 2 * radius);
      arcToLeftDown();
      lineToDown(dy - 2 * radius);
    } else if (dx > 2 * radius) {
      moveTo(start.dx, start.dy - radius);
      arcToUpLeft();
      lineToLeft(dx - 2 * radius);
      arcToLeftDown();
      lineToDown(dy);
    } else if (dy > 6 * radius) {
      moveTo(start.dx, start.dy + radius);
      lineToDown(dy / 3 - 2 * radius);
      arcToDownRight();
      arcToRightDown();
      lineToDown(dy / 3 - 2 * radius);
      arcToDownLeft();
      lineToLeft(dx);
      arcToLeftDown();
      lineToDown(dy / 3 - 2 * radius);
    } else if (dy > 4 * radius) {
      moveTo(start.dx + radius, start.dy);
      arcToRightDown();
      lineToDown(dy / 2 - 2 * radius);
      arcToDownLeft();
      lineToLeft(dx);
      arcToLeftDown();
      lineToDown(dy / 2 - 2 * radius);
    } else {
      moveTo(start.dx + radius, start.dy);
      arcToRightUp();
      arcToUpLeft();
      lineToLeft(dx);
      arcToLeftDown();
      lineToDown(dy);
    }
  }

  @override
  void toLeftUp(double dx, double dy) {
    if (dx > 2 * radius) {
      moveTo(start.dx, start.dy - radius);
      lineToUp(dy);
      arcToUpLeft();
      lineToLeft(dx - 2 * radius);
      arcToLeftDown();
    } else {
      moveTo(start.dx + radius, start.dy);
      arcToRightUp();
      lineToUp(dy);
      arcToUpLeft();
      lineToLeft(dx);
      arcToLeftDown();
    }
  }
}
