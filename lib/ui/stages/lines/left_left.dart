import 'package:studio/ui/stages/line.dart';

class LeftLeft extends Line {
  LeftLeft({
    required super.start,
    required super.end,
    required super.radius,
    required super.style,
  });

  @override
  void toRightDown(double dx, double dy) {
    moveTo(start.dx - radius, start.dy);
    if (dy > 2 * radius) {
      arcToLeftDown();
      lineToDown(dy - 2 * radius);
      arcToDownRight();
      lineToRight(dx);
    } else {
      if (dx > 4 * radius) {
        arcToLeftUp();
        arcToUpRight();
        lineToRight(dx / 2);
        arcToRightDown();
        lineToDown(dy);
        arcToDownRight();
        lineToRight(dx / 2 - 2 * radius);
      } else if (dx > 2 * radius) {
        arcToLeftUp();
        arcToUpRight();
        lineToRight(dx - 2 * radius);
        arcToRightDown();
        lineToDown(dy);
        arcToDownRight();
      } else {
        arcToLeftUp();
        arcToUpLeft();
        arcToLeftDown();
        lineToDown(dy);
        arcToDownRight();
        lineToRight(dx + 2 * radius);
      }
    }
  }

  @override
  void toRightUp(double dx, double dy) {
    moveTo(start.dx - radius, start.dy);
    if (dy > 2 * radius) {
      arcToLeftUp();
      lineToUp(dy - 2 * radius);
      arcToUpRight();
      lineToRight(dx);
    } else {
      if (dx > 4 * radius) {
        arcToLeftDown();
        arcToDownRight();
        lineToRight(dx / 2);
        arcToRightUp();
        lineToUp(dy);
        arcToUpRight();
        lineToRight(dx / 2 - 2 * radius);
      } else if (dx > 2 * radius) {
        arcToLeftDown();
        arcToDownRight();
        lineToRight(dx - 2 * radius);
        arcToRightUp();
        lineToUp(dy);
        arcToUpRight();
      } else {
        arcToLeftDown();
        arcToDownLeft();
        arcToLeftUp();
        lineToUp(dy);
        arcToUpRight();
        lineToRight(dx + 2 * radius);
      }
    }
  }

  @override
  void toLeftDown(double dx, double dy) {
    moveTo(start.dx - radius, start.dy);
    if (dy > 2 * radius) {
      lineToLeft(dx);
      arcToLeftDown();
      lineToDown(dy - 2 * radius);
      arcToDownRight();
    } else {
      if (dx > 4 * radius) {
        lineToLeft(dx / 2 - 2 * radius);
        arcToLeftUp();
        arcToUpLeft();
        lineToLeft(dx / 2);
        arcToLeftDown();
        lineToDown(dy);
        arcToDownRight();
      } else if (dx > 2 * radius) {
        arcToLeftUp();
        arcToUpLeft();
        lineToLeft(dx - 2 * radius);
        arcToLeftDown();
        lineToDown(dy);
        arcToDownRight();
      } else {
        arcToLeftUp();
        arcToUpLeft();
        arcToLeftDown();
        lineToDown(dy);
        arcToDownRight();
        lineToRight(2 * radius - dx);
      }
    }
  }

  @override
  void toLeftUp(double dx, double dy) {
    moveTo(start.dx - radius, start.dy);
    if (dy > 2 * radius) {
      lineToLeft(dx);
      arcToLeftUp();
      lineToUp(dy - 2 * radius);
      arcToUpRight();
    } else {
      if (dx > 4 * radius) {
        lineToLeft(dx / 2 - 2 * radius);
        arcToLeftDown();
        arcToDownLeft();
        lineToLeft(dx / 2);
        arcToLeftUp();
        lineToUp(dy);
        arcToUpRight();
      } else if (dx > 2 * radius) {
        arcToLeftDown();
        arcToDownLeft();
        lineToLeft(dx - 2 * radius);
        arcToLeftUp();
        lineToUp(dy);
        arcToUpRight();
      } else {
        arcToLeftDown();
        arcToDownLeft();
        arcToLeftUp();
        lineToUp(dy);
        arcToUpRight();
        lineToRight(2 * radius - dx);
      }
    }
  }
}
