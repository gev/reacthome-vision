import 'package:flutter/widgets.dart';
import 'package:studio/make/make.dart';
import 'package:ui_kit/acrylic.dart';
import 'package:ui_kit_yaru/init.dart';

void main() async {
  await configureYaruWindow();
  await applyAcrylicEffect();
  initYaruKit();
  runApp(await make());
}
