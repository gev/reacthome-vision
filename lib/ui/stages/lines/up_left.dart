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
