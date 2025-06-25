import 'package:flutter/material.dart';
import 'package:studio/core/scheme.dart';
import 'package:studio/ui/figures/figure.dart';
import 'package:studio/ui/scheme/line.dart';
import 'package:studio/ui/scheme/node.dart';
import 'package:studio/ui/scheme/position.dart';

class SchemeStage<Id> with ChangeNotifier implements Paintable, Hittable {
  final _nodes = <Id, Node>{};
  final _selected = <Node>{};
  final _lines = <Line>[];
  Node? _hit;
  SchemeStage({
    required Scheme<Id> scheme,
    required SchemeStyle style,
    required double gap,
  }) {
    for (final it in scheme.items) {
      final position = Position(Offset(gap * it.x, gap * it.y));
      _nodes[it.id] = (Node(
        center: position,
        type: it.type,
        style: style.nodeStyle,
      ));
    }
    for (final link in scheme.links) {
      final start = _nodes[link.source];
      final end = _nodes[link.sink];
      if (start != null && end != null) {
        _lines.add(
          Line(start: start.center, end: end.center, style: style.lineStyle),
        );
      }
    }
  }

  @override
  void paint(Canvas canvas) {
    for (final it in _lines) {
      it.paint(canvas);
    }
    for (final it in _nodes.values) {
      it.paint(canvas);
    }
    for (final it in _selected) {
      it.paintSelection(canvas);
    }
    _hit?.paintFocus(canvas);
  }

  @override
  bool hitTest(Offset position) {
    for (final it in _nodes.values) {
      if (it.hitTest(position)) {
        if (_selected.contains(it)) {
          if (it == _hit) {
            _selected.remove(it);
          }
        } else {
          _selected.add(it);
        }
        _hit = it;
        notifyListeners();
        return true;
      }
    }
    _hit = null;
    _selected.clear();
    notifyListeners();
    return false;
  }

  void drag(Offset offset) {
    for (final it in _selected) {
      if (it != _hit) {
        it.center.moveBy(offset);
      }
    }
    _hit?.center.moveBy(offset);
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

class SchemeStyle {
  final NodeStyle nodeStyle;
  final LineStyle lineStyle;

  SchemeStyle({required this.nodeStyle, required this.lineStyle});
}
