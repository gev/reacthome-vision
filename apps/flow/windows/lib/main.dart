import 'package:flow/make/make.dart';
import 'package:flutter/widgets.dart';
import 'package:ui_kit_fluent/init.dart';

void main() async {
  await configureFluentWindow(windowSize);
  initFluentKit();
  runApp(await make());
}
