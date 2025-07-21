import 'package:flutter/widgets.dart';
import 'package:studio/make/make.dart';
import 'package:ui_kit_material/kit_material.dart';

void main() async {
  initMaterialKit();
  runApp(await make());
}
