import 'package:flow/make/make.dart';
import 'package:flutter/widgets.dart';
import 'package:ui_kit_linux/init.dart';

void main() async {
  initLinuxKit();
  runApp(await make());
}
