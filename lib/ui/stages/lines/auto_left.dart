import 'package:studio/ui/stages/line.dart';

class AutoLeft extends Line {
  AutoLeft({
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
    } else if (dx > 2 * radius && dy > 2 * radius) {
      moveTo(start.dx, start.dy + radius);
      lineToDown(dy - 2 * radius);
      arcToDownRight();
      lineToRight(dx - 2 * radius);
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
    } else if (dy > 2 * radius) {
      moveTo(start.dx - radius, start.dy);
      arcToLeftDown();
      lineToDown(dy - 2 * radius);
      arcToDownRight();
      lineToRight(dx);
    } else {
      moveTo(start.dx, start.dy - radius);
      arcToUpLeft();
      arcToLeftDown();
      lineToDown(dy);
      arcToDownRight();
      lineToRight(dx);
    }
  }

  @override
  void toRightUp(double dx, double dy) {
    if (dx > 2 * radius && dy == 0) {
      moveTo(start.dx + radius, start.dy);
      lineToRight(dx - 2 * radius);
    } else if (dx > 2 * radius && dy > 2 * radius) {
      moveTo(start.dx, start.dy - radius);
      lineToUp(dy - 2 * radius);
      arcToUpRight();
      lineToRight(dx - 2 * radius);
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
    } else if (dy > 3 * radius) {
      moveTo(start.dx - radius, start.dy);
      arcToLeftUp();
      lineToUp(dy - 2 * radius);
      arcToUpRight();
      lineToRight(dx);
    } else {
      moveTo(start.dx, start.dy + radius);
      arcToDownLeft();
      arcToLeftUp();
      lineToUp(dy);
      arcToUpRight();
      lineToRight(dx);
    }
  }

  @override
  void toLeftDown(double dx, double dy) {
    if (dx > 2 * radius && dy == 0) {
      moveTo(start.dx - radius, start.dy);
      lineToLeft(dx - 2 * radius);
    } else if (dy > 2 * radius) {
      moveTo(start.dx - radius, start.dy);
      lineToLeft(dx);
      arcToLeftDown();
      lineToDown(dy - 2 * radius);
      arcToDownRight();
    } else {
      moveTo(start.dx, start.dy - radius);
      arcToUpLeft();
      lineToLeft(dx);
      arcToLeftDown();
      lineToDown(dy);
      arcToDownRight();
    }
  }

  @override
  void toLeftUp(double dx, double dy) {
    if (dx > 2 * radius && dy == 0) {
      moveTo(start.dx - radius, start.dy);
      lineToLeft(dx - 2 * radius);
    } else if (dy > 2 * radius) {
      moveTo(start.dx - radius, start.dy);
      lineToLeft(dx);
      arcToLeftUp();
      lineToUp(dy - 2 * radius);
      arcToUpRight();
    } else {
      moveTo(start.dx, start.dy + radius);
      arcToDownLeft();
      lineToLeft(dx);
      arcToLeftUp();
      lineToUp(dy);
      arcToUpRight();
    }
  }
}
