import 'package:flow/make/make.dart';
import 'package:flutter/widgets.dart';
import 'package:ui_kit_macos/init.dart';

void main() async {
  initMacOSKit();
  runApp(await make());
}
