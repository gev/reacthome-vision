import 'package:flow/make/make.dart';
import 'package:flutter/widgets.dart';
import 'package:ui_kit_cupertino/init.dart';

void main() async {
  initCupertinoKit();
  runApp(await make());
}
