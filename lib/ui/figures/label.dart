import 'package:flutter/rendering.dart';
import 'package:studio/ui/figures/figure.dart';

class Label implements DisposableFigure {
  final Offset offset;

  // late final Paragraph paragraph;
  late final TextPainter _text;

  Label({
    required String text,
    required this.offset,
    double minWidth = 0,
    double maxWidth = double.infinity,
    TextDirection direction = TextDirection.ltr,
    TextAlign align = TextAlign.start,
    TextStyle? style,
  }) {
    _text = TextPainter(
      text: TextSpan(text: text, style: style),
      textDirection: direction,
      textAlign: align,
    );
    _text.layout(minWidth: minWidth, maxWidth: maxWidth);
  }

  @override
  void paint(Canvas canvas) => _text.paint(canvas, offset);

  @override
  bool hitTest(Offset position) => false;

  @override
  void dispose() => _text.dispose();
}
