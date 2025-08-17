import 'package:flutter/widgets.dart';
import 'package:lab/make/make.dart';
import 'package:ui_kit/layouts/desktop/window_size.dart';
import 'package:ui_kit_yaru/init.dart';

void main() async {
  await configureYaruWindow(windowSize);
  initYaruKit();
  runApp(await make());
}
