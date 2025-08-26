import 'package:flutter/material.dart';
import 'package:iconic/iconic.dart';
import 'package:scheme/stages/node.dart';

class RoundNode extends Node {
  final IconicFactory makeIconic;
  final double radius;
  final double radiusFocussed;
  final double radiusSelected;
  final double _radiusSquared;
  final Iconic _iconic;

  RoundNode({
    required this.makeIconic,
    this.radius = 32,
    this.radiusFocussed = 44,
    this.radiusSelected = 56,
    required super.center,
    required super.style,
  }) : _radiusSquared = radius * radius,
       _iconic = makeIconic(
         offset: center,
         size: 30,
         style: makeIconicStyle(color: style.stroke.color),
       );

  @override
  Node moveTo(Offset offset) => RoundNode(
    makeIconic: makeIconic,
    center: offset,
    radius: radius,
    radiusFocussed: radiusFocussed,
    radiusSelected: radiusSelected,
    style: style,
  );

  @override
  void paint(Canvas canvas) {
    canvas.drawCircle(center, radius + style.sigma, style.background);
    canvas.drawCircle(center, radius, style.fill);
    canvas.drawCircle(center, radius, style.stroke);
    _iconic.paint(canvas);
  }

  @override
  void paintSelection(Canvas canvas) {
    canvas.drawCircle(center, radiusSelected, style.selected);
  }

  @override
  void paintFocus(Canvas canvas) {
    canvas.drawCircle(center, radiusFocussed, style.focused);
  }

  @override
  bool hitTest(Offset position) =>
      (position - center).distanceSquared < _radiusSquared;
}
