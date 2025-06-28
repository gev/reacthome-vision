import 'package:flutter/material.dart';
import 'package:studio/core/item.dart';
import 'package:studio/ui/figures/figure.dart';
import 'package:studio/ui/figures/iconic.dart';
import 'package:studio/ui/figures/iconics/blinds.dart';
import 'package:studio/ui/figures/iconics/arrow.dart';
import 'package:studio/ui/figures/iconics/bar.dart';
import 'package:studio/ui/figures/iconics/button.dart';
import 'package:studio/ui/figures/iconics/curtains.dart';
import 'package:studio/ui/figures/iconics/device.dart';
import 'package:studio/ui/figures/iconics/minus.dart';
import 'package:studio/ui/figures/iconics/mixer.dart';
import 'package:studio/ui/figures/iconics/plus.dart';
import 'package:studio/ui/figures/iconics/qf.dart';
import 'package:studio/ui/figures/iconics/screen.dart';
import 'package:studio/ui/figures/iconics/shutter.dart';
import 'package:studio/ui/figures/iconics/sp.dart';
import 'package:studio/ui/figures/iconics/triangle.dart';
import 'package:studio/ui/scheme/position.dart';

class Node implements Paintable, Hittable {
  final double radius;
  final double radiusFocussed;
  final double radiusSelected;
  final double _radiusSquared;
  final NodeStyle style;
  final Position center;

  final Iconic _iconic;

  Node({
    this.radius = 24,
    this.radiusFocussed = 36,
    this.radiusSelected = 48,
    required this.center,
    required this.style,
    required ItemType type,
  }) : _radiusSquared = radius * radius,
       _iconic = switch (type) {
         ItemType.plus => PlusIconic(
           size: 24,
           iconicStyle: IconicStyle(width: 0.1, color: Colors.red[800]!),
         ),
         ItemType.minus => MinusIconic(
           size: 24,
           iconicStyle: IconicStyle(width: 0.1, color: Colors.blue[800]!),
         ),
         ItemType.arrow => ArrowIconic(
           size: 24,
           iconicStyle: IconicStyle(width: 0.1, color: Colors.green[800]!),
         ),
         ItemType.bar => BarIconic(
           size: 24,
           iconicStyle: IconicStyle(width: 0.1, color: Colors.green[800]!),
         ),
         ItemType.verticalBar => VerticalBarIconic(
           size: 24,
           iconicStyle: IconicStyle(width: 0.1, color: Colors.green[800]!),
         ),
         ItemType.mixer => MixerIconic(
           size: 24,
           iconicStyle: IconicStyle(width: 0.1, color: Colors.green[800]!),
         ),
         ItemType.shutter => ShutterIconic(
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
         ItemType.sp => SPIconic(
           size: 24,
           iconicStyle: IconicStyle(width: 0.1, color: Colors.green[800]!),
         ),
         ItemType.verticalSp => VerticalSPIconic(
           size: 24,
           iconicStyle: IconicStyle(width: 0.1, color: Colors.green[800]!),
         ),
         ItemType.device => DeviceIconic(
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
           size: 24,
           iconicStyle: IconicStyle(width: 0.1, color: Colors.green[800]!),
         ),
       };

  @override
  void paint(Canvas canvas) {
    canvas.drawCircle(center.position, radius, style.fill);
    canvas.drawCircle(center.position, radius, style.stroke);
    _iconic.paint(canvas, center.position);
  }

  void paintSelection(Canvas canvas) {
    canvas.drawCircle(center.position, radiusSelected, style.selected);
  }

  void paintFocus(Canvas canvas) {
    canvas.drawCircle(center.position, radiusFocussed, style.focused);
  }

  @override
  bool hitTest(Offset position) =>
      (position - center.position).distanceSquared < _radiusSquared;
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
    double strokeWidth = 1.0,
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
