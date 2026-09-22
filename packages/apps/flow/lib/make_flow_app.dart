import 'dart:io';

import 'package:flutter/material.dart';
import 'package:vision/glue/runtime/local/local_app.dart';

Future<Widget> makeFlowApp() {
  final codePath = Platform.environment['GLUE_PATH'] ?? "";
  return makeLocalApp(title: 'Flow', codePath: codePath);
}
