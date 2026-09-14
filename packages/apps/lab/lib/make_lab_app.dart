import 'dart:io';

import 'package:flutter/material.dart';
import 'package:vision/mode/local/local_scope.dart';
import 'package:vision/widgets/vision_app.dart';

Future<Widget> makeLabApp() {
  final path = Platform.environment['GLUE_PATH'] ?? "";
  return makeLocalScope(
    child: VisionApp(title: 'Lab'),
    codePath: path,
  );
}
