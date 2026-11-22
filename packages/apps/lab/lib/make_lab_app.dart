import 'dart:io';

import 'package:material_ui/material_ui.dart';
import 'package:vision/glue/runtime/local/dynamic/dynamic_local_app.dart';

Future<Widget> makeLabApp() {
  final path = Platform.environment['GLUE_PATH'] ?? "";
  return makeDynamicLocalApp(title: 'Lab', codePath: path);
}
