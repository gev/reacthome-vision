import 'dart:io';

import 'package:flutter/material.dart';
import 'package:vision/glue/runtime/local/local_app.dart';

Future<Widget> makeLabApp() {
  final path = Platform.environment['GLUE_PATH'] ?? "";
  return makeLocalApp(title: 'Lab', codePath: path);
}
