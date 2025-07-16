import 'package:studio/ui/stages/line.dart';

class DownAny extends Line {
  DownAny({
    required super.start,
    required super.end,
    required super.radius,
    required super.style,
  });

  @override
  void toRightUp(double dx, double dy) {
    moveTo(start.dx, start.dy + radius);
    if (dx > 2 * radius) {
      arcToDownRight();
      lineToRight(dx - 2 * radius);
      arcToRightUp();
      lineToUp(dy);
    } else {
      arcToDownLeft();
      arcToLeftUp();
      lineToUp(dy);
      arcToUpRight();
      lineToRight(dx);
    }
  }

  @override
  void toRightDown(double dx, double dy) {
    moveTo(start.dx, start.dy + radius);
    if (dx == 0 && dy > 2 * radius) {
      lineToDown(dy - 2 * radius);
    } else if (dx > 2 * radius && dy > 2 * radius) {
      lineToDown(dy - 2 * radius);
      arcToDownRight();
      lineToRight(dx - 2 * radius);
    } else if (dx > 4 * radius) {
      lineToDown(dy);
      arcToDownRight();
      lineToRight(dx / 2 - 2 * radius);
      arcToRightUp();
      arcToUpRight();
      lineToRight(dx / 2 - 2 * radius);
    } else if (dy > 4 * radius) {
      lineToDown(dy / 2 - 2 * radius);
      arcToDownLeft();
      arcToLeftDown();
      lineToDown(dy / 2 - 2 * radius);
      arcToDownRight();
      lineToRight(dx);
    } else {
      lineToDown(dy);
      arcToDownLeft();
      arcToLeftUp();
      arcToUpRight();
      lineToRight(dx);
    }
  }

  @override
  void toLeftUp(double dx, double dy) {
    moveTo(start.dx, start.dy + radius);
    if (dx > 2 * radius) {
      arcToDownLeft();
      lineToLeft(dx - 2 * radius);
      arcToLeftUp();
      lineToUp(dy);
    } else {
      arcToDownRight();
      arcToRightUp();
      lineToUp(dy);
      arcToUpLeft();
      lineToLeft(dx);
    }
  }

  @override
  void toLeftDown(double dx, double dy) {
    moveTo(start.dx, start.dy + radius);
    if (dx == 0 && dy > 2 * radius) {
      lineToDown(dy - 2 * radius);
    } else if (dx > 2 * radius && dy > 2 * radius) {
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
}
