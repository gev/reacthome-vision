import 'package:flutter/widgets.dart';
import 'package:lab/ui/widgets/scheme_icon.dart';
import 'package:ui_kit/figures/iconic.dart';
import 'package:ui_kit/figures/iconics/air_conditioner.dart';
import 'package:ui_kit/figures/iconics/arrow.dart';
import 'package:ui_kit/figures/iconics/bar.dart';
import 'package:ui_kit/figures/iconics/blinds.dart';
import 'package:ui_kit/figures/iconics/bra.dart';
import 'package:ui_kit/figures/iconics/button.dart';
import 'package:ui_kit/figures/iconics/chandelier.dart';
import 'package:ui_kit/figures/iconics/curtains.dart';
import 'package:ui_kit/figures/iconics/delay.dart';
import 'package:ui_kit/figures/iconics/device.dart';
import 'package:ui_kit/figures/iconics/drop.dart';
import 'package:ui_kit/figures/iconics/filter.dart';
import 'package:ui_kit/figures/iconics/heater.dart';
import 'package:ui_kit/figures/iconics/led.dart';
import 'package:ui_kit/figures/iconics/minus.dart';
import 'package:ui_kit/figures/iconics/mixer.dart';
import 'package:ui_kit/figures/iconics/plus.dart';
import 'package:ui_kit/figures/iconics/projector.dart';
import 'package:ui_kit/figures/iconics/qf.dart';
import 'package:ui_kit/figures/iconics/screen.dart';
import 'package:ui_kit/figures/iconics/shutter.dart';
import 'package:ui_kit/figures/iconics/sp.dart';
import 'package:ui_kit/figures/iconics/spot.dart';
import 'package:ui_kit/figures/iconics/temperature_sensor.dart';
import 'package:ui_kit/figures/iconics/track.dart';
import 'package:ui_kit/figures/iconics/triangle.dart';

final iconics = <IconicFactory>[
  PlusIconic.new,
  MinusIconic.new,
  RightArrowIconic.new,
  LeftArrowIconic.new,
  TopArrowIconic.new,
  BottomArrowIconic.new,
  HorizontalBarIconic.new,
  VerticalBarIconic.new,
  DownMixerIconic.new,
  VerticalShutterIconic.new,
  HorizontalShutterIconic.new,
  DiagonalShutterIconic.new,
  BackDiagonalShutterIconic.new,
  QFIconic.new,
  ButtonIconic.new,
  RightTriangleIconic.new,
  LeftTriangleIconic.new,
  TopTriangleIconic.new,
  BottomTriangleIconic.new,
  HorizontalSPIconic.new,
  VerticalSPIconic.new,
  DeviceIconic.new,
  ScreenIconic.new,
  CurtainsIconic.new,
  BlindsIconic.new,
  HeaterIconic.new,
  AirConditionerIconic.new,
  ProjectorIconic.new,
  RightFilterIconic.new,
  LeftFilterIconic.new,
  DownFilterIconic.new,
  UpFilterIconic.new,
  ChandelierIconic.new,
  BraIconic.new,
  TrackIconic.new,
  LedIconic.new,
  SpotIconic.new,
  UpMixerIconic.new,
  RightMixerIconic.new,
  LeftMixerIconic.new,
  DelayIconic.new,
  TemperatureSensorIconic.new,
  DropIconic.new,
];

class IconicPalette extends StatelessWidget {
  const IconicPalette({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Wrap(
        children: [
          for (final it in iconics)
            Container(
              padding: const EdgeInsetsGeometry.all(20),
              child: SchemeIcon(makeIconic: it, size: 80),
            ),
        ],
      ),
    );
  }
}
