import '../line.dart';

class RightAuto extends Line {
  RightAuto({
    required super.start,
    required super.end,
    required super.radius,
    required super.style,
  });

  @override
  void toRightDown(double dx, double dy) {
    moveTo(start.dx + radius, start.dy);
    if (dx > 2 * radius && dy == 0) {
      lineToRight(dx - 2 * radius);
    } else if (dx > 2 * radius && dy > 2 * radius) {
      lineToRight(dx - 2 * radius);
      arcToRightDown();
      lineToDown(dy - 2 * radius);
    } else if (dx > 4 * radius) {
      lineToRight(dx / 2 - 2 * radius);
      arcToRightUp();
      arcToUpRight();
      lineToRight(dx / 2 - 2 * radius);
      arcToRightDown();
      lineToDown(dy);
    } else if (dy > 2 * radius) {
      lineToRight(dx);
      arcToRightDown();
      lineToDown(dy - 2 * radius);
      arcToDownLeft();
    } else {
      lineToRight(dx);
      arcToRightUp();
      arcToUpLeft();
      arcToLeftDown();
      lineToDown(dy);
    }
  }

  @override
  void toRightUp(double dx, double dy) {
    moveTo(start.dx + radius, start.dy);
    if (dx > 2 * radius && dy == 0) {
      lineToRight(dx - 2 * radius);
    } else if (dx > 2 * radius && dy > 2 * radius) {
      lineToRight(dx - 2 * radius);
      arcToRightUp();
      lineToUp(dy - 2 * radius);
    } else if (dx > 4 * radius) {
      lineToRight(dx / 2 - 2 * radius);
      arcToRightDown();
      arcToDownRight();
      lineToRight(dx / 2 - 2 * radius);
      arcToRightUp();
      lineToUp(dy);
    } else if (dy > 2 * radius) {
      lineToRight(dx);
      arcToRightUp();
      lineToUp(dy - 2 * radius);
      arcToUpLeft();
    } else {
      lineToRight(dx);
      arcToRightDown();
      arcToDownLeft();
      arcToLeftUp();
      lineToUp(dy);
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
    } else {
      arcToRightUp();
      arcToUpLeft();
      lineToLeft(dx);
      arcToLeftDown();
      lineToDown(dy);
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
    } else {
      arcToRightDown();
      arcToDownLeft();
      lineToLeft(dx);
      arcToLeftUp();
      lineToUp(dy);
    }
  }
}
