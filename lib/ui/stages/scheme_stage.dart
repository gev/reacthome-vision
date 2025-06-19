import 'package:flutter/material.dart';
import 'package:studio/core/item.dart';
import 'package:studio/core/scheme.dart';
import 'package:studio/ui/figures/figure.dart';

class SchemeStage<Id> with ChangeNotifier implements Figure {
  final _stage = <Element<Id>>[];
  final _selected = <Element<Id>>{};

  SchemeStage({
    required TextStyle textStyle,
    required Scheme<Id> scheme,
    required double gap,
  }) {
    for (final it in scheme.items) {
      _stage.add(Element(item: it, gap: gap, textStyle: textStyle));
    }
  }

  @override
  void paint(Canvas canvas) {
    for (final element in _stage) {
      element.paint(canvas);
      if (_selected.contains(element)) {
        element.paintSelection(canvas);
      }
    }
  }

  @override
  bool hitTest(Offset position) {
    for (final element in _stage) {
      if (element.hitTest(position)) {
        if (!_selected.contains(element)) {
          _selected.clear();
          _selected.add(element);
          notifyListeners();
        }
        return true;
      }
    }
    _selected.clear();
    notifyListeners();
    return false;
  }

  void drag(Offset offset) {
    for (final element in _selected) {
      element.moveBy(offset);
    }
    notifyListeners();
  }

  // @override
  // void dispose() {
  //   super.dispose();
  //   for (final element in _stage) {
  //     if (element case Disposable it) {
  //       it.dispose();
  //     }
  //   }
  // }
}

class Element<Id> implements Figure {
  final Id id;
  Offset center;
  final double radius;
  final double radiusSelected;
  final double radiusSquared;
  final Paint style;
  final Paint styleSelected;

  Element({
    required Item<Id> item,
    required double gap,
    this.radius = 24,
    required TextStyle textStyle,
  }) : id = item.id,
       radiusSelected = radius + 12,
       radiusSquared = radius * radius,
       center = Offset(gap * (item.x + 0.5), gap * (item.y + 0.5)),
       style = paintStyle(
         style: PaintingStyle.stroke,
         color: textStyle.color,
         strokeWidth: 4,
       ),
       styleSelected = paintStyle(
         style: PaintingStyle.stroke,
         color: Colors.green[800],
         strokeWidth: 1,
       );

  void moveBy(Offset offset) {
    center += offset;
  }

  @override
  void paint(Canvas canvas) {
    canvas.drawCircle(center, radius, style);
  }

  void paintSelection(Canvas canvas) {
    canvas.drawCircle(center, radiusSelected, styleSelected);
  }

  @override
  bool hitTest(Offset position) =>
      (position - center).distanceSquared < radiusSquared;
}
