import 'package:flutter/material.dart';
import 'package:iconic/figures/iconic.dart';
import 'package:iconic/figures/iconics/air_conditioner.dart';
import 'package:iconic/figures/iconics/arrow.dart';
import 'package:iconic/figures/iconics/bar.dart';
import 'package:iconic/figures/iconics/blinds.dart';
import 'package:iconic/figures/iconics/bra.dart';
import 'package:iconic/figures/iconics/button.dart';
import 'package:iconic/figures/iconics/chandelier.dart';
import 'package:iconic/figures/iconics/curtains.dart';
import 'package:iconic/figures/iconics/delay.dart';
import 'package:iconic/figures/iconics/device.dart';
import 'package:iconic/figures/iconics/drop.dart';
import 'package:iconic/figures/iconics/filter.dart';
import 'package:iconic/figures/iconics/heater.dart';
import 'package:iconic/figures/iconics/led.dart';
import 'package:iconic/figures/iconics/minus.dart';
import 'package:iconic/figures/iconics/mixer.dart';
import 'package:iconic/figures/iconics/plus.dart';
import 'package:iconic/figures/iconics/projector.dart';
import 'package:iconic/figures/iconics/qf.dart';
import 'package:iconic/figures/iconics/screen.dart';
import 'package:iconic/figures/iconics/shutter.dart';
import 'package:iconic/figures/iconics/sp.dart';
import 'package:iconic/figures/iconics/spot.dart';
import 'package:iconic/figures/iconics/temperature_sensor.dart';
import 'package:iconic/figures/iconics/track.dart';
import 'package:iconic/figures/iconics/triangle.dart';
import 'package:scheme/core/item.dart';

Iconic selectIconic({
  required ItemType type,
  required Offset offset,
  required double size,
  required IconicStyle style,
}) => switch (type) {
  ItemType.plus => PlusIconic.new,
  ItemType.minus => MinusIconic.new,
  ItemType.rightArrow => RightArrowIconic.new,
  ItemType.leftArrow => LeftArrowIconic.new,
  ItemType.topArrow => TopArrowIconic.new,
  ItemType.bottomArrow => BottomArrowIconic.new,
  ItemType.horizontalBar => HorizontalBarIconic.new,
  ItemType.verticalBar => VerticalBarIconic.new,
  ItemType.downMixer => DownMixerIconic.new,
  ItemType.verticalShutter => VerticalShutterIconic.new,
  ItemType.horizontalShutter => HorizontalShutterIconic.new,
  ItemType.diagonalShutterIconic => DiagonalShutterIconic.new,
  ItemType.backDiagonalShutterIconic => BackDiagonalShutterIconic.new,
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
  ItemType.airConditioner => AirConditionerIconic.new,
  ItemType.projector => ProjectorIconic.new,
  ItemType.rightFilter => RightFilterIconic.new,
  ItemType.leftFilter => LeftFilterIconic.new,
  ItemType.downFilter => DownFilterIconic.new,
  ItemType.upFilter => UpFilterIconic.new,
  ItemType.chandelier => ChandelierIconic.new,
  ItemType.bra => BraIconic.new,
  ItemType.track => TrackIconic.new,
  ItemType.led => LedIconic.new,
  ItemType.spot => SpotIconic.new,
  ItemType.upMixer => UpMixerIconic.new,
  ItemType.rightMixer => RightMixerIconic.new,
  ItemType.leftMixer => LeftMixerIconic.new,
  ItemType.delay => DelayIconic.new,
  ItemType.temperatureSensor => TemperatureSensorIconic.new,
  ItemType.drop => DropIconic.new,
}(offset: offset, size: size, style: style);
