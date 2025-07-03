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

final iconicStyle = IconicStyle(width: 0.05, color: Colors.amber[800]!);

Iconic selectIconic(ItemType type, Offset offset) => switch (type) {
  ItemType.plus => PlusIconic.new,
  ItemType.minus => MinusIconic.new,
  ItemType.rightArrow => RightArrowIconic.new,
  ItemType.leftArrow => LeftArrowIconic.new,
  ItemType.topArrow => TopArrowIconic.new,
  ItemType.bottomArrow => BottomArrowIconic.new,
  ItemType.horizontalBar => HorizontalBarIconic.new,
  ItemType.verticalBar => VerticalBarIconic.new,
  ItemType.mixer => MixerIconic.new,
  ItemType.verticalShutter => VerticalShutterIconic.new,
  ItemType.horizontalShutter => HorizontalShutterIconic.new,
  ItemType.qf => QFIconic.new,
  ItemType.button => ButtonIconic.new,
  ItemType.rightTriangle => RightTriangleIconic.new,
  ItemType.leftTriangle => LeftTriangleIconic.new,
  ItemType.topTriangle => TopTriangleIconic.new,
  ItemType.bottomTriangle => BottomTriangleIconic.new,
  ItemType.horizontalSP => HorizontalSPIconic.new,
  ItemType.verticalSP => VerticalSPIconic.new,
  ItemType.device => DeviceIconic.new,
  ItemType.screen => ScreenIconic.new,
  ItemType.curtains => CurtainsIconic.new,
  ItemType.blinds => BlindsIconic.new,
  ItemType.heater => HeaterIconic.new,
}(offset: offset, size: 24, iconicStyle: iconicStyle);

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
