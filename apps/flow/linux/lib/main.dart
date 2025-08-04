import 'package:flow/make/make.dart';
import 'package:flutter/widgets.dart';
import 'package:ui_kit_yaru/init.dart';

void main() async {
  await configureYaruWindow();
  initYaruKit();
  runApp(await make());
}
