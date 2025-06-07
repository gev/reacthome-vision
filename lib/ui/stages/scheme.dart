import 'package:flutter/widgets.dart';
import 'package:studio/scheme/element.dart';
import 'package:studio/ui/figures/circle.dart';
import 'package:studio/ui/figures/figure.dart';
import 'package:studio/ui/figures/stage.dart';

class Scheme implements DisposableFigure {
  late final Stage _stage;

  Scheme({
    required TextStyle textStyle,
    required Items items,
    required double gap,
  }) {
    _stage = Stage(
      figures: items
          .map(
            (item) => Circle(
              center: Offset(gap * (item.x + 0.5), gap * (item.y + 0.5)),
              radius: 25,
              style: paintStyle(
                style: PaintingStyle.stroke,
                color: textStyle.color,
                strokeWidth: 4,
              ),
            ),
          )
          .toList(),
    );
  }

  @override
  void paint(Canvas canvas) => _stage.paint(canvas);

  @override
  bool hitTest(Offset position) => _stage.hitTest(position);

  @override
  void dispose() => _stage.dispose();
}
