import 'package:studio/ui/stages/line_path.dart';

class LeftLeft extends LinePath {
  LeftLeft({required super.start, required super.end, required super.radius});

  @override
  void toRightDown(double dx, double dy) {
    lineToLeft(radius);
    if (dy > 2 * radius) {
      arcToLeftDown();
      lineToDown(dy - 2 * radius);
    } else {
      arcToLeftUp();
      if (dx > 3 * radius) {
        arcToUpRight();
        lineToRight(dx / 2 - radius);
        arcToRightDown();
      } else {
        arcToUpLeft();
        arcToLeftDown();
      }
      lineToDown(dy);
    }
    arcToDownRight();
  }

  @override
  void toRightUp(double dx, double dy) {
    lineToLeft(radius);
    if (dy > 2 * radius) {
      arcToLeftUp();
      lineToUp(dy - 2 * radius);
    } else {
      arcToLeftDown();
      if (dx > 3 * radius) {
        arcToDownRight();
        lineToRight(dx / 2 - radius);
        arcToRightUp();
      } else {
        arcToDownLeft();
        arcToLeftUp();
      }
      lineToUp(dy);
    }
    arcToUpRight();
  }

  @override
  void toLeftDown(double dx, double dy) {
    lineToLeft(radius);
    if (dy > 2 * radius) {
      lineToLeft(dx);
      arcToLeftDown();
      lineToDown(dy - 2 * radius);
    } else {
      if (dx > 2 * radius) {
        lineToLeft(dx / 2 - radius);
        arcToLeftUp();
        arcToUpLeft();
        lineToLeft(dx / 2 - radius);
      } else {
        arcToLeftUp();
        arcToUpLeft();
      }
      arcToLeftDown();
      lineToDown(dy);
    }
    arcToDownRight();
  }

  @override
  void toLeftUp(double dx, double dy) {
    lineToLeft(radius);
    if (dy > 2 * radius) {
      lineToLeft(dx);
      arcToLeftUp();
      lineToUp(dy - 2 * radius);
    } else {
      if (dx > 2 * radius) {
        lineToLeft(dx / 2 - radius);
        arcToLeftDown();
        arcToDownLeft();
        lineToLeft(dx / 2 - radius);
      } else {
        arcToLeftDown();
        arcToDownLeft();
      }
      arcToLeftUp();
      lineToUp(dy);
    }
    arcToUpRight();
  }
}
