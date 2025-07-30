import 'package:flutter/widgets.dart';
import 'package:studio/make/make.dart';
import 'package:ui_kit_macos/init.dart';

void main() async {
  await configureMacosWindowUtils();
  initMacOSKit();
  runApp(await make());
}

void initMacosKit() {}
