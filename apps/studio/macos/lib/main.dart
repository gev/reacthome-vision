import 'package:flutter/widgets.dart';
// import 'package:macos_ui/macos_ui.dart';
import 'package:studio/make/make.dart';
import 'package:ui_kit_cupertino/kit_cupertino.dart';

// Future<void> configureMacosWindowUtils() async {
//   const config = MacosWindowUtilsConfig();
//   await config.apply();
// }

void main() async {
  // if (Platform.isMacOS) {
  //   await configureMacosWindowUtils();
  // }
  initCupertinoKit();
  runApp(await make());
}
