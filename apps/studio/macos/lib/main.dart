import 'package:flutter/widgets.dart';
// import 'package:macos_ui/macos_ui.dart';
import 'package:studio/make/make.dart';
import 'package:ui_kit_macos/init.dart';

// Future<void> configureMacosWindowUtils() async {
//   const config = MacosWindowUtilsConfig();
//   await config.apply();
// }

void main() async {
  // if (Platform.isMacOS) {
  //   await configureMacosWindowUtils();
  // }
  initMacOSKit();
  runApp(await make());
}

void initMacosKit() {}
