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

  SchemeStage({
    required ThemeContainer theme,
    required Scheme<Id> scheme,
    required double gap,
  }) {
    final textStyle = theme.bodyStyle!;
    for (final it in scheme.items) {
      _nodes[it.id] = (Node(
        item: it,
        gap: gap,
        color: textStyle.color!,
        selectedColor: Colors.green[800]!,
      ));
    }
    for (final link in scheme.links) {
      final start = _nodes[link.source];
      final end = _nodes[link.sink];
      if (start != null && end != null) {
        _lines.add(
          Line(id: link.id, start: start, end: end, color: textStyle.color!),
        );
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
      if (_selectedNodes.contains(element)) {
        element.paintSelection(canvas);
      }
    }
  }

  @override
  bool hitTest(Offset position) {
    for (final element in _nodes.values) {
      if (element.hitTest(position)) {
        if (!_selectedNodes.contains(element)) {
          _selectedNodes.clear();
          _selectedNodes.add(element);
          notifyListeners();
        }
        return true;
      }
    }
    _selectedNodes.clear();
    notifyListeners();
    return false;
  }

  void drag(Offset offset) {
    for (final element in _selectedNodes) {
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
