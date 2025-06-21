import 'package:flutter/material.dart';
import 'package:studio/core/scheme.dart';
import 'package:studio/ui/figures/figure.dart';
import 'package:studio/ui/scheme/line.dart';
import 'package:studio/ui/scheme/node.dart';
import 'package:studio/ui_kit/theme/theme.dart';

class SchemeStage<Id> with ChangeNotifier implements Figure {
  final _nodes = <Id, Node<Id>>{};
  final _selectedNodes = <Node<Id>>{};
  final _lines = <Line<Id>>[];
  Node<Id>? _hit;

  SchemeStage({
    required ThemeContainer theme,
    required Scheme<Id> scheme,
    required double gap,
  }) {
    for (final it in scheme.items) {
      _nodes[it.id] = (Node(item: it, gap: gap, theme: theme));
    }
    for (final link in scheme.links) {
      final start = _nodes[link.source];
      final end = _nodes[link.sink];
      if (start != null && end != null) {
        _lines.add(Line(id: link.id, start: start, end: end, theme: theme));
      }
    }
  }

  @override
  void paint(Canvas canvas) {
    for (final line in _lines) {
      line.paint(canvas);
    }
    for (final element in _nodes.values) {
      element.paint(canvas);
    }
    for (final element in _selectedNodes) {
      element.paintSelection(canvas);
    }
    _hit?.paintFocus(canvas);
  }

  @override
  bool hitTest(Offset position) {
    for (final element in _nodes.values) {
      if (element.hitTest(position)) {
        if (_selectedNodes.contains(element)) {
          if (element == _hit) {
            _selectedNodes.remove(element);
          }
        } else {
          _selectedNodes.add(element);
        }
        _hit = element;
        notifyListeners();
        return true;
      }
    }
    _hit = null;
    _selectedNodes.clear();
    notifyListeners();
    return false;
  }

  void drag(Offset offset) {
    for (final element in _selectedNodes) {
      if (element != _hit) {
        element.moveBy(offset);
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
