import 'package:scheme/stages/line.dart';

class AutoRight extends Line {
  AutoRight({
    required super.start,
    required super.end,
    required super.radius,
    required super.style,
  });

  @override
  void toRightDown(double dx, double dy) {
    if (dy > 2 * radius) {
      moveTo(start.dx + radius, start.dy);
      lineToRight(dx);
      arcToRightDown();
      lineToDown(dy - 2 * radius);
      arcToDownLeft();
    } else {
      moveTo(start.dx, start.dy - radius);
      arcToUpRight();
      lineToRight(dx);
      arcToRightDown();
      lineToDown(dy);
      arcToDownLeft();
    }
  }

  @override
  void toRightUp(double dx, double dy) {
    if (dy > 2 * radius) {
      moveTo(start.dx + radius, start.dy);
      lineToRight(dx);
      arcToRightUp();
      lineToUp(dy - 2 * radius);
      arcToUpLeft();
    } else {
      moveTo(start.dx, start.dy + radius);
      arcToDownRight();
      lineToRight(dx);
      arcToRightUp();
      lineToUp(dy);
      arcToUpLeft();
    }
  }

  @override
  void toLeftDown(double dx, double dy) {
    if (dx > 2 * radius && dy == 0) {
      moveTo(start.dx - radius, start.dy);
      lineToLeft(dx - 2 * radius);
    } else if (dx > 2 * radius && dy > 2 * radius) {
      moveTo(start.dx, start.dy + radius);
      lineToDown(dy - 2 * radius);
      arcToDownLeft();
      lineToLeft(dx - 2 * radius);
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
    } else if (dy > 2 * radius) {
      moveTo(start.dx + radius, start.dy);
      arcToRightDown();
      lineToDown(dy - 2 * radius);
      arcToDownLeft();
      lineToLeft(dx);
    } else {
      moveTo(start.dx, start.dy - radius);
      arcToUpRight();
      arcToRightDown();
      lineToDown(dy);
      arcToDownLeft();
      lineToLeft(dx);
    }
  }

  @override
  void toLeftUp(double dx, double dy) {
    if (dx > 2 * radius && dy == 0) {
      moveTo(start.dx - radius, start.dy);
      lineToLeft(dx - 2 * radius);
    } else if (dx > 2 * radius && dy > 2 * radius) {
      moveTo(start.dx, start.dy - radius);
      lineToUp(dy - 2 * radius);
      arcToUpLeft();
      lineToLeft(dx - 2 * radius);
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
    } else if (dy > 3 * radius) {
      moveTo(start.dx + radius, start.dy);
      arcToRightUp();
      lineToUp(dy - 2 * radius);
      arcToUpLeft();
      lineToLeft(dx);
    } else {
      moveTo(start.dx, start.dy + radius);
      arcToDownRight();
      arcToRightUp();
      lineToUp(dy);
      arcToUpLeft();
      lineToLeft(dx);
    }
  }
}
