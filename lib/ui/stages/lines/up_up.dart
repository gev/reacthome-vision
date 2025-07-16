import 'package:studio/ui/stages/line.dart';

class UpUp extends Line {
  UpUp({
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
    } else if (dy > 4 * radius) {
      arcToUpLeft();
      arcToLeftDown();
      lineToDown(dy / 2);
      arcToDownRight();
      lineToRight(dx);
      arcToRightDown();
      lineToDown(dy / 2 - 2 * radius);
    } else if (dy > 2 * radius) {
      arcToUpLeft();
      arcToLeftDown();
      lineToDown(dy - 2 * radius);
      arcToDownRight();
      lineToRight(dx);
      arcToRightDown();
    } else {
      arcToUpLeft();
      arcToLeftUp();
      arcToUpRight();
      lineToRight(dx);
      arcToRightDown();
      lineToDown(dy + 2 * radius);
    }
  }

  @override
  void toRightUp(double dx, double dy) {
    moveTo(start.dx, start.dy - radius);
    if (dx > 2 * radius) {
      lineToUp(dy);
      arcToUpRight();
      lineToRight(dx - 2 * radius);
      arcToRightDown();
    } else if (dy > 4 * radius) {
      lineToUp(dy / 2 - 2 * radius);
      arcToUpLeft();
      arcToLeftUp();
      lineToUp(dy / 2);
      arcToUpRight();
      lineToRight(dx);
      arcToRightDown();
    } else if (dy > 2 * radius) {
      arcToUpLeft();
      arcToLeftUp();
      lineToUp(dy - 2 * radius);
      arcToUpRight();
      lineToRight(dx);
      arcToRightDown();
    } else {
      arcToUpLeft();
      arcToLeftUp();
      arcToUpRight();
      lineToRight(dx);
      arcToRightDown();
      lineToDown(2 * radius - dy);
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
    } else if (dy > 4 * radius) {
      arcToUpRight();
      arcToRightDown();
      lineToDown(dy / 2);
      arcToDownLeft();
      lineToLeft(dx);
      arcToLeftDown();
      lineToDown(dy / 2 - 2 * radius);
    } else if (dy > 2 * radius) {
      arcToUpRight();
      arcToRightDown();
      lineToDown(dy - 2 * radius);
      arcToDownLeft();
      lineToLeft(dx);
      arcToLeftDown();
    } else {
      arcToUpRight();
      arcToRightUp();
      arcToUpLeft();
      lineToLeft(dx);
      arcToLeftDown();
      lineToDown(dy + 2 * radius);
    }
  }

  @override
  void toLeftUp(double dx, double dy) {
    moveTo(start.dx, start.dy - radius);
    if (dx > 2 * radius) {
      lineToUp(dy);
      arcToUpLeft();
      lineToLeft(dx - 2 * radius);
      arcToLeftDown();
    } else if (dy > 4 * radius) {
      lineToUp(dy / 2 - 2 * radius);
      arcToUpRight();
      arcToRightUp();
      lineToUp(dy / 2);
      arcToUpLeft();
      lineToLeft(dx);
      arcToLeftDown();
    } else if (dy > 2 * radius) {
      arcToUpRight();
      arcToRightUp();
      lineToUp(dy - 2 * radius);
      arcToUpLeft();
      lineToLeft(dx);
      arcToLeftDown();
    } else {
      arcToUpRight();
      arcToRightUp();
      arcToUpLeft();
      lineToLeft(dx);
      arcToLeftDown();
      lineToDown(2 * radius - dy);
    }
  }
}
