import 'package:studio/ui/stages/line.dart';

class RightRight extends Line {
  RightRight({
    required super.start,
    required super.end,
    required super.radius,
    required super.style,
  });

  @override
  void toRightDown(double dx, double dy) {
    moveTo(start.dx + radius, start.dy);
    if (dy > 2 * radius) {
      lineToRight(dx);
      arcToRightDown();
      lineToDown(dy - 2 * radius);
      arcToDownLeft();
    } else if (dx > 4 * radius) {
      lineToRight(dx / 2 - 2 * radius);
      arcToRightUp();
      arcToUpRight();
      lineToRight(dx / 2);
      arcToRightDown();
      lineToDown(dy);
      arcToDownLeft();
    } else if (dx > 2 * radius) {
      arcToRightUp();
      arcToUpRight();
      lineToRight(dx - 2 * radius);
      arcToRightDown();
      lineToDown(dy);
      arcToDownLeft();
    } else {
      arcToRightUp();
      arcToUpRight();
      arcToRightDown();
      lineToDown(dy);
      arcToDownLeft();
      lineToLeft(2 * radius - dx);
    }
  }

  @override
  void toRightUp(double dx, double dy) {
    moveTo(start.dx + radius, start.dy);
    if (dy > 2 * radius) {
      lineToRight(dx);
      arcToRightUp();
      lineToUp(dy - 2 * radius);
      arcToUpLeft();
    } else if (dx > 4 * radius) {
      lineToRight(dx / 2 - 2 * radius);
      arcToRightDown();
      arcToDownRight();
      lineToRight(dx / 2);
      arcToRightUp();
      lineToUp(dy);
      arcToUpLeft();
    } else if (dx > 2 * radius) {
      arcToRightDown();
      arcToDownRight();
      lineToRight(dx - 2 * radius);
      arcToRightUp();
      lineToUp(dy);
      arcToUpLeft();
    } else {
      arcToRightDown();
      arcToDownRight();
      arcToRightUp();
      lineToUp(dy);
      arcToUpLeft();
      lineToLeft(2 * radius - dx);
    }
  }

  @override
  void toLeftDown(double dx, double dy) {
    moveTo(start.dx + radius, start.dy);
    if (dy > 2 * radius) {
      arcToRightDown();
      lineToDown(dy - 2 * radius);
      arcToDownLeft();
      lineToLeft(dx);
    } else if (dx > 4 * radius) {
      arcToRightUp();
      arcToUpLeft();
      lineToLeft(dx / 2);
      arcToLeftDown();
      lineToDown(dy);
      arcToDownLeft();
      lineToLeft(dx / 2 - 2 * radius);
    } else if (dx > 2 * radius) {
      arcToRightUp();
      arcToUpLeft();
      lineToLeft(dx - 2 * radius);
      arcToLeftDown();
      lineToDown(dy);
      arcToDownLeft();
    } else {
      arcToRightUp();
      arcToUpRight();
      arcToRightDown();
      lineToDown(dy);
      arcToDownLeft();
      lineToLeft(dx + 2 * radius);
    }
  }

  @override
  void toLeftUp(double dx, double dy) {
    moveTo(start.dx + radius, start.dy);
    if (dy > 2 * radius) {
      arcToRightUp();
      lineToUp(dy - 2 * radius);
      arcToUpLeft();
      lineToLeft(dx);
    } else if (dx > 4 * radius) {
      arcToRightDown();
      arcToDownLeft();
      lineToLeft(dx / 2);
      arcToLeftUp();
      lineToUp(dy);
      arcToUpLeft();
      lineToLeft(dx / 2 - 2 * radius);
    } else if (dx > 2 * radius) {
      arcToRightDown();
      arcToDownLeft();
      lineToLeft(dx - 2 * radius);
      arcToLeftUp();
      lineToUp(dy);
      arcToUpLeft();
    } else {
      arcToRightDown();
      arcToDownRight();
      arcToRightUp();
      lineToUp(dy);
      arcToUpLeft();
      lineToLeft(dx + 2 * radius);
    }
  }
}
