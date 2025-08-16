import 'package:scheme/stages/line.dart';

class DownDown extends Line {
  DownDown({
    required super.start,
    required super.end,
    required super.radius,
    required super.style,
  });

  @override
  void toRightDown(double dx, double dy) {
    moveTo(start.dx, start.dy + radius);
    if (dx > 2 * radius) {
      lineToDown(dy);
      arcToDownRight();
      lineToRight(dx - 2 * radius);
      arcToRightUp();
    } else if (dy > 4 * radius) {
      lineToDown(dy / 2 - 2 * radius);
      arcToDownLeft();
      arcToLeftDown();
      lineToDown(dy / 2);
      arcToDownRight();
      lineToRight(dx);
      arcToRightUp();
    } else if (dy > 2 * radius) {
      arcToDownLeft();
      arcToLeftDown();
      lineToDown(dy - 2 * radius);
      arcToDownRight();
      lineToRight(dx);
      arcToRightUp();
    } else {
      arcToDownLeft();
      arcToLeftDown();
      arcToDownRight();
      lineToRight(dx);
      arcToRightUp();
      lineToUp(2 * radius - dy);
    }
  }

  @override
  void toRightUp(double dx, double dy) {
    moveTo(start.dx, start.dy + radius);
    if (dx > 2 * radius) {
      arcToDownRight();
      lineToRight(dx - 2 * radius);
      arcToRightUp();
      lineToUp(dy);
    } else if (dy > 4 * radius) {
      arcToDownLeft();
      arcToLeftUp();
      lineToUp(dy / 2);
      arcToUpRight();
      lineToRight(dx);
      arcToRightUp();
      lineToUp(dy / 2 - 2 * radius);
    } else if (dy > 2 * radius) {
      arcToDownLeft();
      arcToLeftUp();
      lineToUp(dy - 2 * radius);
      arcToUpRight();
      lineToRight(dx);
      arcToRightUp();
    } else {
      arcToDownLeft();
      arcToLeftDown();
      arcToDownRight();
      lineToRight(dx);
      arcToRightUp();
      lineToUp(dy + 2 * radius);
    }
  }

  @override
  void toLeftDown(double dx, double dy) {
    moveTo(start.dx, start.dy + radius);
    if (dx > 2 * radius) {
      lineToDown(dy);
      arcToDownLeft();
      lineToLeft(dx - 2 * radius);
      arcToLeftUp();
    } else if (dy > 4 * radius) {
      lineToDown(dy / 2 - 2 * radius);
      arcToDownRight();
      arcToRightDown();
      lineToDown(dy / 2);
      arcToDownLeft();
      lineToLeft(dx);
      arcToLeftUp();
    } else if (dy > 2 * radius) {
      arcToDownRight();
      arcToRightDown();
      lineToDown(dy - 2 * radius);
      arcToDownLeft();
      lineToLeft(dx);
      arcToLeftUp();
    } else {
      arcToDownRight();
      arcToRightDown();
      arcToDownLeft();
      lineToLeft(dx);
      arcToLeftUp();
      lineToUp(2 * radius - dy);
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
    } else if (dy > 4 * radius) {
      arcToDownRight();
      arcToRightUp();
      lineToUp(dy / 2);
      arcToUpLeft();
      lineToLeft(dx);
      arcToLeftUp();
      lineToUp(dy / 2 - 2 * radius);
    } else if (dy > 2 * radius) {
      arcToDownRight();
      arcToRightUp();
      lineToUp(dy - 2 * radius);
      arcToUpLeft();
      lineToLeft(dx);
      arcToLeftUp();
    } else {
      arcToDownRight();
      arcToRightDown();
      arcToDownLeft();
      lineToLeft(dx);
      arcToLeftUp();
      lineToUp(dy + 2 * radius);
    }
  }
}
