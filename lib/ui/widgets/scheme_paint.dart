import 'package:flutter/widgets.dart';

class SchemePaint extends StatelessWidget {
  final CustomPainter painter;

  const SchemePaint({required this.painter, super.key});

  @override
  Widget build(BuildContext context) => SizedBox.expand(
    child: RepaintBoundary(child: CustomPaint(painter: painter)),
  );
}
