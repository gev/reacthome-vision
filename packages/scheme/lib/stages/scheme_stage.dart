import 'package:flutter/material.dart';
import 'package:scheme/core/link.dart';
import 'package:scheme/core/scheme.dart';
import 'package:scheme/stages/anchor_line.dart';
import 'package:scheme/stages/line.dart';
import 'package:scheme/stages/node.dart';
import 'package:ui_kit/figures/figure.dart';

class Ref<T> {
  Ref(this.ref);
  T ref;
}

class SchemeStage<Id> with ChangeNotifier implements Paintable, Hittable {
  final SchemeStyle style;
  final double gap;
  final _nodes = <Id, Ref<Node>>{};
  final _selected = <Ref<Node>>{};
  final _lineIndex = <Ref<Node>, Set<Link<Id>>>{};
  final _lines = <Id, ({AnchorLine line, Node source, Node sink})>{};
  Ref<Node>? _hit;

  SchemeStage({
    required Scheme<Id> scheme,
    required this.style,
    required this.gap,
  }) {
    for (final it in scheme.items) {
      final position = Offset(gap * it.x, gap * it.y);
      final node = (Ref(
        Node(type: it.type, center: position, style: style.nodeStyle),
      ));
      _nodes[it.id] = node;
      _lineIndex[node] = {};
    }
    for (final link in scheme.links) {
      final start = _nodes[link.source.id];
      final end = _nodes[link.sink.id];
      _lineIndex[start]?.add(link);
      _lineIndex[end]?.add(link);
    }
    scheme.links.forEach(_makeLine);
  }

  @override
  void paint(Canvas canvas) {
    final painted = <Node>{};
    for (final it in _lines.values) {
      if (!painted.contains(it.source)) {
        it.source.paint(canvas);
        painted.add(it.source);
      }
      if (!painted.contains(it.sink)) {
        it.sink.paint(canvas);
        painted.add(it.sink);
      }
      it.line.paint(canvas);
    }
    for (final it in _selected) {
      it.ref.paintSelection(canvas);
    }
    _hit?.ref.paintFocus(canvas);
  }

  @override
  bool hitTest(Offset position) {
    for (final it in _nodes.values.toList().reversed) {
      if (it.ref.hitTest(position)) {
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
    final hit = _hit;
    for (final it in _selected) {
      if (it != hit) {
        _moveBy(it, offset);
      }
    }
    if (hit != null) {
      _moveBy(hit, offset);
    }
    notifyListeners();
  }

  double round(double a) => (a / gap).roundToDouble() * gap;

  void snapPosition(Ref<Node> node) {
    _moveTo(node, Offset(round(node.ref.center.dx), round(node.ref.center.dy)));
  }

  void dragged() {
    final hit = _hit;
    for (final it in _selected) {
      if (it != hit) {
        snapPosition(it);
      }
    }
    if (hit != null) {
      snapPosition(hit);
    }
    notifyListeners();
  }

  void _moveTo(Ref<Node> node, Offset offset) {
    node.ref = node.ref.moveTo(offset);
    _updateLine(node);
  }

  void _moveBy(Ref<Node> node, Offset offset) {
    node.ref = node.ref.moveBy(offset);
    _updateLine(node);
  }

  void _updateLine(Ref<Node> node) {
    final links = _lineIndex[node];
    if (links != null) {
      for (final link in links) {
        _makeLine(link);
      }
    }
  }

  void _makeLine(Link<Id> link) {
    final start = _nodes[link.source.id];
    final end = _nodes[link.sink.id];
    if (start != null && end != null) {
      _lines[link.id] = (
        line: AnchorLine(
          start: (direction: link.source.direction, offset: start.ref.center),
          end: (direction: link.sink.direction, offset: end.ref.center),
          style: style.lineStyle,
        ),
        source: start.ref,
        sink: end.ref,
      );
    }
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
