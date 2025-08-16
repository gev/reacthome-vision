import 'package:flutter/widgets.dart';
import 'package:lab/make/make.dart';
import 'package:ui_kit_yaru/init.dart';

void main() async {
  initYaruKit();
  runApp(await make());
}
