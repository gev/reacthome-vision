import 'package:flutter/rendering.dart';
import 'package:studio/ui/stages/scheme.dart';

class SchemePainter extends CustomPainter {
  final Scheme scheme;

  const SchemePainter({required this.scheme});

  @override
  void paint(Canvas canvas, Size size) => scheme.paint(canvas);

  @override
  bool hitTest(Offset position) => scheme.hitTest(position);

  @override
  bool shouldRepaint(SchemePainter oldDelegate) => oldDelegate.scheme != scheme;
}
