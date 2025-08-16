import 'package:scheme/stages/line.dart';

class AutoAuto extends Line {
  AutoAuto({
    required super.start,
    required super.end,
    required super.radius,
    required super.style,
  });

  @override
  void toRightDown(double dx, double dy) {
    if (dx > 2 * radius && dy == 0) {
      moveTo(start.dx + radius, start.dy);
      lineToRight(dx - 2 * radius);
    } else if (dx == 0 && dy > 2 * radius) {
      moveTo(start.dx, start.dy - radius);
      lineToDown(dy - 2 * radius);
    } else if (dx > 2 * radius && dy > 2 * radius) {
      moveTo(start.dx + radius, start.dy);
      lineToRight(dx - 2 * radius);
      arcToRightDown();
      lineToDown(dy - 2 * radius);
    } else if (dx > 6 * radius) {
      moveTo(start.dx + radius, start.dy);
      lineToRight(dx / 3 - 2 * radius);
      arcToRightUp();
      arcToUpRight();
      lineToRight(dx / 3 - 2 * radius);
      arcToRightDown();
      lineToDown(dy);
      arcToDownRight();
      lineToRight(dx / 3 - 2 * radius);
    } else if (dx > 4 * radius) {
      moveTo(start.dx, start.dy - radius);
      arcToUpRight();
      lineToRight(dx / 2 - 2 * radius);
      arcToRightDown();
      lineToDown(dy);
      arcToDownRight();
      lineToRight(dx / 2 - 2 * radius);
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
    } else if (dy > 2 * radius) {
      moveTo(start.dx - radius, start.dy);
      arcToLeftDown();
      lineToDown(dy - 2 * radius);
      arcToDownRight();
      lineToRight(dx);
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
    if (dx > 2 * radius && dy == 0) {
      moveTo(start.dx + radius, start.dy);
      lineToRight(dx - 2 * radius);
    } else if (dx > 2 * radius && dy == 0) {
      moveTo(start.dx + radius, start.dy);
      lineToRight(dx - 2 * radius);
    } else if (dx == 0 && dy > 2 * radius) {
      moveTo(start.dx, start.dy + radius);
      lineToUp(dy - 2 * radius);
    } else if (dx > 2 * radius && dy > 2 * radius) {
      moveTo(start.dx + radius, start.dy);
      lineToRight(dx - 2 * radius);
      arcToRightUp();
      lineToUp(dy - 2 * radius);
    } else if (dx > 6 * radius) {
      moveTo(start.dx + radius, start.dy);
      lineToRight(dx / 3 - 2 * radius);
      arcToRightDown();
      arcToDownRight();
      lineToRight(dx / 3 - 2 * radius);
      arcToRightUp();
      lineToUp(dy);
      arcToUpRight();
      lineToRight(dx / 3 - 2 * radius);
    } else if (dx > 4 * radius) {
      moveTo(start.dx, start.dy + radius);
      arcToDownRight();
      lineToRight(dx / 2 - 2 * radius);
      arcToRightUp();
      lineToUp(dy);
      arcToUpRight();
      lineToRight(dx / 2 - 2 * radius);
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
    } else if (dy > 2 * radius) {
      moveTo(start.dx - radius, start.dy);
      arcToLeftUp();
      lineToUp(dy - 2 * radius);
      arcToUpRight();
      lineToRight(dx);
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
    if (dx > 2 * radius && dy == 0) {
      moveTo(start.dx - radius, start.dy);
      lineToLeft(dx - 2 * radius);
    } else if (dx == 0 && dy > 2 * radius) {
      moveTo(start.dx, start.dy + radius);
      lineToDown(dy - 2 * radius);
    } else if (dx > 2 * radius && dy > 2 * radius) {
      moveTo(start.dx - radius, start.dy);
      lineToLeft(dx - 2 * radius);
      arcToLeftDown();
      lineToDown(dy - 2 * radius);
    } else if (dx > 6 * radius) {
      moveTo(start.dx - radius, start.dy);
      lineToLeft(dx / 3 - 2 * radius);
      arcToLeftUp();
      arcToUpLeft();
      lineToLeft(dx / 3 - 2 * radius);
      arcToLeftDown();
      lineToDown(dy);
      arcToDownLeft();
      lineToLeft(dx / 3 - 2 * radius);
    } else if (dx > 4 * radius) {
      moveTo(start.dx, start.dy - radius);
      arcToUpLeft();
      lineToLeft(dx / 2 - 2 * radius);
      arcToLeftDown();
      lineToDown(dy);
      arcToDownLeft();
      lineToLeft(dx / 2 - 2 * radius);
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
    } else if (dy > 2 * radius) {
      moveTo(start.dx + radius, start.dy);
      arcToRightDown();
      lineToDown(dy - 2 * radius);
      arcToDownLeft();
      lineToLeft(dx);
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
    if (dx > 2 * radius && dy == 0) {
      moveTo(start.dx - radius, start.dy);
      lineToLeft(dx - 2 * radius);
    } else if (dx == 0 && dy > 2 * radius) {
      moveTo(start.dx, start.dy - radius);
      lineToUp(dy - 2 * radius);
    } else if (dx > 2 * radius && dy > 2 * radius) {
      moveTo(start.dx - radius, start.dy);
      lineToLeft(dx - 2 * radius);
      arcToLeftUp();
      lineToUp(dy - 2 * radius);
    } else if (dx > 6 * radius) {
      moveTo(start.dx - radius, start.dy);
      lineToLeft(dx / 3 - 2 * radius);
      arcToLeftDown();
      arcToDownLeft();
      lineToLeft(dx / 3 - 2 * radius);
      arcToLeftUp();
      lineToUp(dy);
      arcToUpLeft();
      lineToLeft(dx / 3 - 2 * radius);
    } else if (dx > 4 * radius) {
      moveTo(start.dx, start.dy + radius);
      arcToDownLeft();
      lineToLeft(dx / 2 - 2 * radius);
      arcToLeftUp();
      lineToUp(dy);
      arcToUpLeft();
      lineToLeft(dx / 2 - 2 * radius);
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
    } else if (dy > 2 * radius) {
      moveTo(start.dx + radius, start.dy);
      arcToRightUp();
      lineToUp(dy - 2 * radius);
      arcToUpLeft();
      lineToLeft(dx);
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
