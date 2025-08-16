import 'package:scheme/stages/line.dart';

class LeftAuto extends Line {
  LeftAuto({
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
      arcToLeftUp();
      arcToUpRight();
      lineToRight(dx);
      arcToRightDown();
      lineToDown(dy);
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
      arcToLeftDown();
      arcToDownRight();
      lineToRight(dx);
      arcToRightUp();
      lineToUp(dy);
    }
  }

  @override
  void toLeftDown(double dx, double dy) {
    moveTo(start.dx - radius, start.dy);
    if (dx > 2 * radius && dy == 0) {
      lineToLeft(dx - 2 * radius);
    } else if (dx > 2 * radius && dy > 2 * radius) {
      lineToLeft(dx - 2 * radius);
      arcToLeftDown();
      lineToDown(dy - 2 * radius);
    } else if (dx > 4 * radius) {
      lineToLeft(dx / 2 - 2 * radius);
      arcToLeftUp();
      arcToUpLeft();
      lineToLeft(dx / 2 - 2 * radius);
      arcToLeftDown();
      lineToDown(dy);
    } else if (dy > 2 * radius) {
      lineToLeft(dx);
      arcToLeftDown();
      lineToDown(dy - 2 * radius);
      arcToDownRight();
    } else {
      lineToLeft(dx);
      arcToLeftUp();
      arcToUpRight();
      arcToRightDown();
      lineToDown(dy);
    }
  }

  @override
  void toLeftUp(double dx, double dy) {
    moveTo(start.dx - radius, start.dy);
    if (dx > 2 * radius && dy == 0) {
      lineToLeft(dx - 2 * radius);
    } else if (dx > 2 * radius && dy > 2 * radius) {
      lineToLeft(dx - 2 * radius);
      arcToLeftUp();
      lineToUp(dy - 2 * radius);
    } else if (dx > 4 * radius) {
      lineToLeft(dx / 2 - 2 * radius);
      arcToLeftDown();
      arcToDownLeft();
      lineToLeft(dx / 2 - 2 * radius);
      arcToLeftUp();
      lineToUp(dy);
    } else if (dy > 2 * radius) {
      lineToLeft(dx);
      arcToLeftUp();
      lineToUp(dy - 2 * radius);
      arcToUpRight();
    } else {
      lineToLeft(dx);
      arcToLeftDown();
      arcToDownRight();
      arcToRightUp();
      lineToUp(dy);
    }
  }
}
