import 'package:flutter/widgets.dart';
import 'package:studio/make/make.dart';
import 'package:ui_kit/layouts/desktop/window_size.dart';
import 'package:ui_kit_macos/init.dart';

void main() async {
  await configureMacosWindow(windowSize);
  initMacOSKit();
  runApp(await make());
}
