import 'package:studio/ui/stages/line.dart';

class UpLeft extends Line {
  UpLeft({
    required super.start,
    required super.end,
    required super.radius,
    required super.style,
  });

  @override
  void toRightDown(double dx, double dy) {
    moveTo(start.dx, end.dy - radius);
    if (dx > 2 * radius && dy > 2 * radius) {
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
    } else if (dy > 4 * radius) {
      lineToLeft(dx);
      arcToLeftDown();
      lineToDown(dy / 2 - 2 * radius);
      arcToDownRight();
      arcToRightDown();
      lineToDown(dy / 2 - 2 * radius);
    } else {
      lineToLeft(dx);
      arcToLeftUp();
      arcToUpRight();
      arcToRightDown();
      lineToDown(dy);
    }
  }

  @override
  void toRightUp(double dx, double dy) {
    moveTo(start.dx, end.dy - radius);
  }

  @override
  void toLeftDown(double dx, double dy) {
    moveTo(start.dx, end.dy - radius);
  }

  @override
  void toLeftUp(double dx, double dy) {
    moveTo(start.dx, end.dy - radius);
  }
}
