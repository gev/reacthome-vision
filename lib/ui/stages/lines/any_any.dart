import 'package:studio/ui/stages/line.dart';

class AnyAny extends Line {
  AnyAny({
    required super.start,
    required super.end,
    required super.radius,
    required super.style,
  });

  @override
  void toRightDown(double dx, double dy) {
    if (dx < 2 * radius && dy == 0) {
      moveTo(start.dx + 2 * radius, start.dy);
      lineToRight(dx - 2 * radius);
    } else if (dx == 0 && dy > 2 * radius) {
      moveTo(start.dx, start.dy - radius);
      lineToDown(dy - 2 * radius);
    } else if (dx > 2 * radius && dy > 2 * radius) {
      moveTo(start.dx + radius, start.dy);
      lineToRight(dx - 2 * radius);
      arcToRightDown();
      lineToDown(dy - 2 * radius);
    } else if (dx > 2 * radius) {
      moveTo(start.dx, start.dy - radius);
      arcToUpRight();
      lineToRight(dx - 2 * radius);
      arcToRightDown();
      lineToDown(dy);
    } else if (dy > 6 * radius) {
      moveTo(start.dx, start.dy + radius);
      lineToDown(dy / 3 - 2 * radius);
      arcToDownLeft();
      arcToLeftDown();
      lineToDown(dy / 3 - 2 * radius);
      arcToDownRight();
      lineToRight(dx);
      arcToRightDown();
      lineToDown(dy / 3 - 2 * radius);
    } else if (dy > 4 * radius) {
      moveTo(start.dx - radius, start.dy);
      arcToLeftDown();
      lineToDown(dy / 2 - 2 * radius);
      arcToDownRight();
      lineToRight(dx);
      arcToRightDown();
      lineToDown(dy / 2 - 2 * radius);
    } else {
      moveTo(start.dx - radius, start.dy);
      arcToLeftUp();
      arcToUpRight();
      lineToRight(dx);
      arcToRightDown();
      lineToDown(dy);
    }
  }
}
