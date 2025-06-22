import 'package:flutter/material.dart';
import 'package:studio/core/scheme.dart';
import 'package:studio/ui/figures/figure.dart';
import 'package:studio/ui/scheme/line.dart';
import 'package:studio/ui/scheme/node.dart';
import 'package:studio/ui/scheme/vertex.dart';
import 'package:studio/ui_kit/theme/theme.dart';

class SchemeStage<Id> with ChangeNotifier implements Figure {
  final _vertices = <Id, Vertex>{};
  final _selected = <Vertex>{};
  final _lines = <Line>[];
  final Node _node;
  Vertex? _hit;

  SchemeStage({
    required ThemeContainer theme,
    required Scheme<Id> scheme,
    required double gap,
  }) : _node = Node(
         radius: 24,
         style: NodeStyle(
           color: theme.color,
           backgroundColor: theme.backgroundColor,
           selectedColor: theme.color.withAlpha(128),
           focussedColor: theme.primaryColor,
         ),
       ) {
    for (final it in scheme.items) {
      _vertices[it.id] = Vertex(Offset(gap * it.x, gap * it.y));
    }
    final lineStyle = LineStyle(
      color: theme.color.withAlpha(192),
      strokeWidth: 1.0,
    );
    for (final link in scheme.links) {
      final start = _vertices[link.source];
      final end = _vertices[link.sink];
      if (start != null && end != null) {
        _lines.add(Line(start: start, end: end, style: lineStyle));
      }
    }
  }

  @override
  void paint(Canvas canvas) {
    for (final it in _lines) {
      it.paint(canvas);
    }
    for (final it in _vertices.values) {
      _node.paint(canvas, it.position);
    }
    for (final it in _selected) {
      _node.paintSelection(canvas, it.position);
    }
    if (_hit != null) {
      _node.paintFocus(canvas, _hit!.position);
    }
  }

  @override
  bool hitTest(Offset position) {
    for (final it in _vertices.values) {
      if (_node.hitTest(position, it.position)) {
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
        it.moveBy(offset);
      }
    }
    _hit?.moveBy(offset);
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
