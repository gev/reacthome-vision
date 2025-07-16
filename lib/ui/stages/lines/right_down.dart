import 'package:studio/ui/stages/line.dart';

class RightDown extends Line {
  RightDown({
    required super.start,
    required super.end,
    required super.radius,
    required super.style,
  });

  @override
  void toRightDown(double dx, double dy) {
    moveTo(start.dx + radius, start.dy);
    if (dx > 4 * radius) {
      lineToRight(dx / 2 - 2 * radius);
      arcToRightDown();
      lineToDown(dy);
      arcToDownRight();
      lineToRight(dx / 2 - 2 * radius);
      arcToRightUp();
    } else {
      lineToRight(dx);
      arcToRightDown();
      lineToDown(dy);
      arcToDownLeft();
      arcToLeftUp();
    }
  }

  @override
  void toRightUp(double dx, double dy) {
    moveTo(start.dx + radius, start.dy);
    if (dx > 2 * radius && dy > 2 * radius) {
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
    } else if (dy > 4 * radius) {
      lineToRight(dx);
      arcToRightUp();
      lineToUp(dy / 2 - 2 * radius);
      arcToUpLeft();
      arcToLeftUp();
      lineToUp(dy / 2 - 2 * radius);
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
    arcToRightDown();
    lineToDown(dy);
    arcToDownLeft();
    lineToLeft(dx);
    arcToLeftUp();
  }

  @override
  void toLeftUp(double dx, double dy) {
    moveTo(start.dx + radius, start.dy);
    if (dy > 4 * radius) {
      arcToRightUp();
      lineToUp(dy / 2 - 2 * radius);
      arcToUpLeft();
      lineToLeft(dx);
      arcToLeftUp();
      lineToUp(dy / 2 - 2 * radius);
    } else {
      arcToRightDown();
      arcToDownLeft();
      lineToLeft(dx);
      arcToLeftUp();
      lineToUp(dy);
    }
  }
}
