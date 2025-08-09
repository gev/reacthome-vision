import 'package:flutter/widgets.dart';
import 'package:studio/make/make.dart';
import 'package:ui_kit_fluent/init.dart';

void main() async {
  await configureFluentWindows();
  initFluentKit();
  runApp(await make());
}
