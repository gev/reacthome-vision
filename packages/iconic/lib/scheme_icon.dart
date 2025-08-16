import 'package:flutter/widgets.dart';
import 'package:iconic/iconic.dart';
import 'package:ui_kit/widgets.dart';

class SchemeIcon extends StatelessWidget {
  final IconicFactory makeIconic;
  final double size;
  final Size _size;
  final Offset _offset;

  SchemeIcon({required this.makeIconic, required this.size, super.key})
    : _size = Size(size, size),
      _offset = Offset(size / 2, size / 2);

  @override
  Widget build(BuildContext context) {
    final theme = UI.themeOf(context);
    final style = makeIconicStyle(theme.color);
    return RepaintBoundary(
      child: CustomPaint(
        painter: _IconicPainter(
          makeIconic(offset: _offset, size: size, style: style),
        ),
        size: _size,
      ),
    );
  }
}

class _IconicPainter extends CustomPainter {
  final Iconic iconic;

  const _IconicPainter(this.iconic);

  @override
  void paint(Canvas canvas, Size size) {
    iconic.paint(canvas);
  }

  @override
  bool shouldRepaint(covariant _IconicPainter oldDelegate) =>
      iconic != oldDelegate.iconic;
}
