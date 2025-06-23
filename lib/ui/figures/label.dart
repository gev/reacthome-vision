import 'package:flutter/rendering.dart';
import 'package:studio/ui/figures/figure.dart';

class Label implements PaintableAt, Disposable {
  // late final Paragraph paragraph;
  late final TextPainter _text;

  Label({
    required String text,
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
  void paint(Canvas canvas, Offset offset) => _text.paint(canvas, offset);

  @override
  bool hitTest(Offset position, Offset offset) => false;

  @override
  void dispose() => _text.dispose();
}
