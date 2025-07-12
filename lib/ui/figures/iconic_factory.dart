import 'package:flutter/material.dart';
import 'package:studio/core/item.dart';
import 'package:studio/ui/figures/iconic.dart';
import 'package:studio/ui/figures/iconics/air_conditioner.dart';
import 'package:studio/ui/figures/iconics/arrow.dart';
import 'package:studio/ui/figures/iconics/bar.dart';
import 'package:studio/ui/figures/iconics/blinds.dart';
import 'package:studio/ui/figures/iconics/bra.dart';
import 'package:studio/ui/figures/iconics/button.dart';
import 'package:studio/ui/figures/iconics/chandelier.dart';
import 'package:studio/ui/figures/iconics/curtains.dart';
import 'package:studio/ui/figures/iconics/delay.dart';
import 'package:studio/ui/figures/iconics/device.dart';
import 'package:studio/ui/figures/iconics/filter.dart';
import 'package:studio/ui/figures/iconics/heater.dart';
import 'package:studio/ui/figures/iconics/led.dart';
import 'package:studio/ui/figures/iconics/minus.dart';
import 'package:studio/ui/figures/iconics/mixer.dart';
import 'package:studio/ui/figures/iconics/plus.dart';
import 'package:studio/ui/figures/iconics/projector.dart';
import 'package:studio/ui/figures/iconics/qf.dart';
import 'package:studio/ui/figures/iconics/screen.dart';
import 'package:studio/ui/figures/iconics/shutter.dart';
import 'package:studio/ui/figures/iconics/sp.dart';
import 'package:studio/ui/figures/iconics/spot.dart';
import 'package:studio/ui/figures/iconics/temperature_sensor.dart';
import 'package:studio/ui/figures/iconics/track.dart';
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
}(offset: offset, size: 30, iconicStyle: iconicStyle);
