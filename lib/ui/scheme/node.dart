import 'package:flutter/material.dart';
import 'package:studio/core/item.dart';
import 'package:studio/ui/figures/figure.dart';
import 'package:studio/ui/figures/iconic.dart';
import 'package:studio/ui/figures/iconics/arrow.dart';
import 'package:studio/ui/figures/iconics/bar.dart';
import 'package:studio/ui/figures/iconics/blinds.dart';
import 'package:studio/ui/figures/iconics/button.dart';
import 'package:studio/ui/figures/iconics/curtains.dart';
import 'package:studio/ui/figures/iconics/device.dart';
import 'package:studio/ui/figures/iconics/heater.dart';
import 'package:studio/ui/figures/iconics/minus.dart';
import 'package:studio/ui/figures/iconics/mixer.dart';
import 'package:studio/ui/figures/iconics/plus.dart';
import 'package:studio/ui/figures/iconics/qf.dart';
import 'package:studio/ui/figures/iconics/screen.dart';
import 'package:studio/ui/figures/iconics/shutter.dart';
import 'package:studio/ui/figures/iconics/sp.dart';
import 'package:studio/ui/figures/iconics/triangle.dart';

Iconic selectIconic(ItemType type, Offset offset) => switch (type) {
  ItemType.plus => PlusIconic(
    size: 24,
    iconicStyle: IconicStyle(width: 0.1, color: Colors.red[800]!),
  ),
  ItemType.minus => MinusIconic(
    size: 24,
    iconicStyle: IconicStyle(width: 0.1, color: Colors.blue[800]!),
  ),
  ItemType.rightArrow => RightArrowIconic(
    offset: offset,
    size: 24,
    iconicStyle: IconicStyle(width: 0.1, color: Colors.green[800]!),
  ),
  ItemType.leftArrow => LeftArrowIconic(
    offset: offset,
    size: 24,
    iconicStyle: IconicStyle(width: 0.1, color: Colors.green[800]!),
  ),
  ItemType.topArrow => TopArrowIconic(
    offset: offset,
    size: 24,
    iconicStyle: IconicStyle(width: 0.1, color: Colors.green[800]!),
  ),
  ItemType.bottomArrow => BottomArrowIconic(
    offset: offset,
    size: 24,
    iconicStyle: IconicStyle(width: 0.1, color: Colors.green[800]!),
  ),
  ItemType.horizontalBar => HorizontalBarIconic(
    offset: offset,
    size: 24,
    iconicStyle: IconicStyle(width: 0.1, color: Colors.green[800]!),
  ),
  ItemType.verticalBar => VerticalBarIconic(
    offset: offset,
    size: 24,
    iconicStyle: IconicStyle(width: 0.1, color: Colors.green[800]!),
  ),
  ItemType.mixer => MixerIconic(
    size: 24,
    iconicStyle: IconicStyle(width: 0.1, color: Colors.green[800]!),
  ),
  ItemType.verticalShutter => VerticalShutterIconic(
    size: 24,
    iconicStyle: IconicStyle(width: 0.1, color: Colors.green[800]!),
  ),
  ItemType.horizontalShutter => HorizontalShutterIconic(
    size: 24,
    iconicStyle: IconicStyle(width: 0.1, color: Colors.green[800]!),
  ),
  ItemType.qf => QFIconic(
    size: 24,
    iconicStyle: IconicStyle(width: 0.1, color: Colors.green[800]!),
  ),
  ItemType.button => ButtonIconic(
    offset: offset,
    size: 24,
    iconicStyle: IconicStyle(width: 0.1, color: Colors.green[800]!),
  ),
  ItemType.rightTriangle => RightTriangleIconic(
    size: 24,
    iconicStyle: IconicStyle(width: 0.1, color: Colors.green[800]!),
  ),
  ItemType.leftTriangle => LeftTriangleIconic(
    size: 24,
    iconicStyle: IconicStyle(width: 0.1, color: Colors.green[800]!),
  ),
  ItemType.topTriangle => TopTriangleIconic(
    size: 24,
    iconicStyle: IconicStyle(width: 0.1, color: Colors.green[800]!),
  ),
  ItemType.bottomTriangle => BottomTriangleIconic(
    size: 24,
    iconicStyle: IconicStyle(width: 0.1, color: Colors.green[800]!),
  ),
  ItemType.horizontalSP => HorizontalSPIconic(
    size: 24,
    iconicStyle: IconicStyle(width: 0.1, color: Colors.green[800]!),
  ),
  ItemType.verticalSP => VerticalSPIconic(
    size: 24,
    iconicStyle: IconicStyle(width: 0.1, color: Colors.green[800]!),
  ),
  ItemType.device => DeviceIconic(
    offset: offset,
    size: 24,
    iconicStyle: IconicStyle(width: 0.1, color: Colors.green[800]!),
  ),
  ItemType.screen => ScreenIconic(
    size: 24,
    iconicStyle: IconicStyle(width: 0.1, color: Colors.green[800]!),
  ),
  ItemType.curtains => CurtainsIconic(
    size: 24,
    iconicStyle: IconicStyle(width: 0.1, color: Colors.green[800]!),
  ),
  ItemType.blinds => BlindsIconic(
    offset: offset,
    size: 24,
    iconicStyle: IconicStyle(width: 0.1, color: Colors.green[800]!),
  ),
  ItemType.heater => HeaterIconic(
    size: 24,
    iconicStyle: IconicStyle(width: 0.1, color: Colors.green[800]!),
  ),
};

class Node implements Paintable, Hittable {
  final ItemType type;
  final double radius;
  final double radiusFocussed;
  final double radiusSelected;
  final double _radiusSquared;
  final NodeStyle style;
  final Offset center;
  final Iconic _iconic;

  Node({
    required this.type,
    this.radius = 24,
    this.radiusFocussed = 36,
    this.radiusSelected = 48,
    required this.center,
    required this.style,
  }) : _radiusSquared = radius * radius,
       _iconic = selectIconic(type, center);

  Node moveTo(Offset offset) => Node(
    type: type,
    center: offset,
    radius: radius,
    radiusFocussed: radiusFocussed,
    radiusSelected: radiusSelected,
    style: style,
  );

  Node moveBy(Offset offset) => moveTo(center + offset);

  @override
  void paint(Canvas canvas) {
    canvas.drawCircle(center, radius, style.fill);
    canvas.drawCircle(center, radius, style.stroke);
    _iconic.paint(canvas);
  }

  void paintSelection(Canvas canvas) {
    canvas.drawCircle(center, radiusSelected, style.selected);
  }

  void paintFocus(Canvas canvas) {
    canvas.drawCircle(center, radiusFocussed, style.focused);
  }

  @override
  bool hitTest(Offset position) =>
      (position - center).distanceSquared < _radiusSquared;
}

class NodeStyle {
  final Paint fill;
  final Paint stroke;
  final Paint selected;
  final Paint focused;

  NodeStyle({
    required Color color,
    required Color backgroundColor,
    required Color selectedColor,
    required Color focusedColor,
    double strokeWidth = 4.0,
    double focussedWidth = 2.0,
    double selectedWidth = 0.5,
  }) : fill = Paint()
         ..style = PaintingStyle.fill
         ..color = backgroundColor,
       stroke = Paint()
         ..style = PaintingStyle.stroke
         ..color = color
         ..strokeWidth = strokeWidth,
       selected = Paint()
         ..style = PaintingStyle.stroke
         ..color = selectedColor
         ..strokeWidth = selectedWidth,
       focused = Paint()
         ..style = PaintingStyle.stroke
         ..color = focusedColor
         ..strokeWidth = focussedWidth;
}
