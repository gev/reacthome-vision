import 'package:flutter/material.dart';
import 'package:iconic/iconics/plus.dart';
import 'package:scheme/core/link.dart' show Link;
import 'package:scheme/core/scheme.dart';
import 'package:scheme/stages/anchor_line.dart';
import 'package:scheme/stages/line.dart';
import 'package:scheme/stages/node.dart';
import 'package:scheme/stages/nodes/round_node.dart';
import 'package:ui_kit/figures/figure.dart';

class SchemeStage<Id> with ChangeNotifier implements Paintable, Hittable {
  final SchemeStyle style;
  final double gap;
  final Scheme<Id> scheme;
  final _lines = <Id, AnchorLine>{};
  final _nodes = <Id, Node>{};
  final _selected = <Id>{};
  Id? _hit;

  SchemeStage({required this.scheme, required this.style, required this.gap});

  @override
  void paint(Canvas canvas) {
    final painted = <Id>{};
    for (final it in scheme.links) {
      paintLink(canvas, it, painted);
    }
    for (final it in scheme.items) {
      paintItem(canvas, it.id, painted);
    }
    for (final it in _selected) {
      getNode(it).paintSelection(canvas);
    }
    final hit = _hit;
    if (hit != null) {
      getNode(hit).paintFocus(canvas);
    }
  }

  void paintLink(Canvas canvas, Link<Id> link, Set<Id> painted) {
    paintItem(canvas, link.source.id, painted);
    paintItem(canvas, link.sink.id, painted);
    paintLine(canvas, link);
  }

  void paintItem(Canvas canvas, Id id, Set<Id> painted) {
    if (!painted.contains(id)) {
      paintNode(canvas, id);
      painted.add(id);
    }
  }

  void paintLine(Canvas canvas, Link link) {
    getLine(link).paint(canvas);
  }

  void paintNode(Canvas canvas, Id id) {
    getNode(id).paint(canvas);
  }

  AnchorLine getLine(Link link) {
    var line = _lines[link.id];
    line ??= AnchorLine(
      start: (
        offset: scheme.item(link.source.id).offset * gap,
        direction: link.source.direction,
      ),
      end: (
        offset: scheme.item(link.sink.id).offset * gap,
        direction: link.sink.direction,
      ),
      style: style.lineStyle,
    );
    _lines[link.id] = line;
    return line;
  }

  Node getNode(Id id) {
    var node = _nodes[id];
    node ??= RoundNode(
      makeIconic: PlusIconic.new,
      center: scheme.item(id).offset * gap,
      style: style.nodeStyle,
    );
    _nodes[id] = node;
    return node;
  }

  @override
  bool hitTest(Offset position) {
    for (final it in scheme.items.toList().reversed) {
      final node = getNode(it.id);
      if (node.hitTest(position)) {
        if (_selected.contains(it)) {
          if (it == _hit) {
            _selected.remove(it);
          }
        } else {
          _selected.add(it.id);
        }
        _hit = it.id;
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
    // final hit = _hit;
    // for (final it in _selected) {
    //   if (it != hit) {
    //     _moveBy(it, offset);
    //   }
    // }
    // if (hit != null) {
    //   _moveBy(hit, offset);
    // }
    notifyListeners();
  }

  double round(double a) => (a / gap).roundToDouble() * gap;

  void snapPosition(Node node) {
    // _moveTo(node, Offset(round(node.center.dx), round(node.center.dy)));
  }

  void dragged() {
    //   final hit = _hit;
    //   for (final it in _selected) {
    //     if (it != hit) {
    //       snapPosition(it);
    //     }
    //   }
    //   if (hit != null) {
    //     snapPosition(hit);
    //   }
    //   notifyListeners();
  }
}

class SchemeStyle {
  final NodeStyle nodeStyle;
  final LineStyle lineStyle;

  SchemeStyle({required this.nodeStyle, required this.lineStyle});
}
