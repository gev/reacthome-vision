import 'dart:io';

import 'package:flutter/material.dart';
import 'package:vision/mode/local/local_scope.dart';
import 'package:vision/widgets/vision_app.dart';

Future<Widget> makeFlowApp() {
  final path = Platform.environment['GLUE_PATH'] ?? "";
  return makeLocalScope(
    child: VisionApp(title: 'Flow'),
    codePath: path,
  );
  // return makeLiveScope(
  //   host: '192.168.11.101',
  //   port: 3005,
  //   child: VisionApp(title: 'Flow'),
  // );
}
