import 'package:flutter/rendering.dart';
import 'package:studio/ui/stages/scheme_stage.dart';

class SchemePainter extends CustomPainter {
  final SchemeStage scheme;

  const SchemePainter({required this.scheme}) : super(repaint: scheme);

  @override
  void paint(Canvas canvas, Size size) {
    scheme.paint(canvas);
  }

  @override
  bool shouldRepaint(SchemePainter oldDelegate) => oldDelegate.scheme != scheme;
}
