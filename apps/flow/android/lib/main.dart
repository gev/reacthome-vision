import 'package:flow/make/make.dart';
import 'package:flutter/widgets.dart';
import 'package:ui_kit_material/init.dart';

void main() async {
  initMaterialKit();
  runApp(await make());
}
