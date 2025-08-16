import 'package:flutter/widgets.dart';
import 'package:lab/make/make.dart';
import 'package:ui_kit_material/init.dart';

void main() async {
  initMaterialKit();
  runApp(await make());
}
