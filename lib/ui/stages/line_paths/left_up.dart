import 'package:studio/ui/stages/line_path.dart';

class LeftUp extends LinePath {
  LeftUp({required super.start, required super.end, required super.radius});

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
    lineToLeft(radius);
    if (dx > 2 * radius && dy > 2 * radius) {
      lineToLeft(dx - 2 * radius);
      arcToLeftDown();
    } else {
      if (dx > 4 * radius) {
        arcToLeftUp();
        arcToUpLeft();
        lineToLeft(dx - 4 * radius);
        arcToLeftDown();
      } else if (dy > 4 * radius) {
        lineToLeft(dx);
        arcToLeftDown();
        lineToDown(dy / 2 - 2 * radius);
        arcToDownRight();
        arcToRightDown();
      } else {
        lineToLeft(dx);
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
