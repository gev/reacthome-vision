import 'dart:ui';

import 'package:studio/ui/figures/iconic.dart';

const k_arrow_length = 0.5;

abstract class ArrowIconic extends Iconic {
  final double arrowLength;
  ArrowIconic({required super.size, required super.iconicStyle})
    : arrowLength = size * k_arrow_length;
}

class RightArrowIconic extends ArrowIconic {
  RightArrowIconic({required super.size, required super.iconicStyle});
  @override
  void paint(Canvas canvas, Offset offset) {
    canvas.drawLine(
      Offset(offset.dx - arrowLength, offset.dy),
      Offset(offset.dx + arrowLength, offset.dy),
      strokeStyle,
    );
    canvas.drawLine(
      Offset(offset.dx + arrowLength, offset.dy),
      Offset(offset.dx, offset.dy + arrowLength),
      strokeStyle,
    );
    canvas.drawLine(
      Offset(offset.dx + arrowLength, offset.dy),
      Offset(offset.dx, offset.dy - arrowLength),
      strokeStyle,
    );
  }
}

class LeftArrowIconic extends ArrowIconic {
  LeftArrowIconic({required super.size, required super.iconicStyle});
  @override
  void paint(Canvas canvas, Offset offset) {
    canvas.drawLine(
      Offset(offset.dx - arrowLength, offset.dy),
      Offset(offset.dx + arrowLength, offset.dy),
      strokeStyle,
    );
    canvas.drawLine(
      Offset(offset.dx - arrowLength, offset.dy),
      Offset(offset.dx, offset.dy + arrowLength),
      strokeStyle,
    );
    canvas.drawLine(
      Offset(offset.dx - arrowLength, offset.dy),
      Offset(offset.dx, offset.dy - arrowLength),
      strokeStyle,
    );
  }
}

class TopArrowIconic extends ArrowIconic {
  TopArrowIconic({required super.size, required super.iconicStyle});
  @override
  void paint(Canvas canvas, Offset offset) {
    canvas.drawLine(
      Offset(offset.dx, offset.dy - arrowLength),
      Offset(offset.dx, offset.dy + arrowLength),
      strokeStyle,
    );
    canvas.drawLine(
      Offset(offset.dx - arrowLength, offset.dy),
      Offset(offset.dx, offset.dy - arrowLength),
      strokeStyle,
    );
    canvas.drawLine(
      Offset(offset.dx + arrowLength, offset.dy),
      Offset(offset.dx, offset.dy - arrowLength),
      strokeStyle,
    );
  }
}

class BottomArrowIconic extends ArrowIconic {
  BottomArrowIconic({required super.size, required super.iconicStyle});
  @override
  void paint(Canvas canvas, Offset offset) {
    canvas.drawLine(
      Offset(offset.dx, offset.dy - arrowLength),
      Offset(offset.dx, offset.dy + arrowLength),
      strokeStyle,
    );
    canvas.drawLine(
      Offset(offset.dx + arrowLength, offset.dy),
      Offset(offset.dx, offset.dy + arrowLength),
      strokeStyle,
    );
    canvas.drawLine(
      Offset(offset.dx - arrowLength, offset.dy),
      Offset(offset.dx, offset.dy + arrowLength),
      strokeStyle,
    );
  }
}
