import 'package:studio/ui/stages/line.dart';

class LeftUp extends Line {
  LeftUp({
    required super.start,
    required super.end,
    required super.radius,
    required super.style,
  });

  @override
  void toRightDown(double dx, double dy) {
    lineToLeft(radius);
    if (dy > 4 * radius) {
      arcToLeftDown();
      lineToDown(dy / 2 - 2 * radius);
      arcToDownRight();
    } else {
      arcToLeftUp();
      arcToUpRight();
    }
    lineToRight(dx);
    arcToRightDown();
  }

  @override
  void toRightUp(double dx, double dy) {
    lineToLeft(radius);
    arcToLeftUp();
    lineToUp(dy);
    arcToUpRight();
    lineToRight(dx);
    arcToRightDown();
  }

  @override
  void toLeftDown(double dx, double dy) {
    if (dx > 2 * radius && dy > 2 * radius) {
      lineToLeft(dx - radius);
      arcToLeftDown();
    } else {
      if (dx > 4 * radius) {
        lineToLeft(dx / 2 - 2 * radius);
        lineToLeft(radius);
        arcToLeftUp();
        arcToUpLeft();
        lineToLeft(dx / 2 - 2 * radius);
        arcToLeftDown();
      } else if (dy > 4 * radius) {
        lineToLeft(dx + radius);
        arcToLeftDown();
        lineToDown(dy / 2 - 2 * radius);
        arcToDownRight();
        arcToRightDown();
      } else {
        lineToLeft(dx + radius);
        arcToLeftUp();
        arcToUpRight();
        arcToRightDown();
      }
    }
  }

  @override
  void toLeftUp(double dx, double dy) {
    if (dx > 4 * radius) {
      lineToLeft(dx / 2 - 2 * radius);
      lineToLeft(radius);
      arcToLeftUp();
      lineToUp(dy);
      arcToUpLeft();
      lineToLeft(dx / 2 - 2 * radius);
      arcToLeftDown();
    } else {
      lineToLeft(radius);
      lineToLeft(dx);
      arcToLeftUp();
      lineToUp(dy);
      arcToUpRight();
      arcToRightDown();
    }
  }
}
