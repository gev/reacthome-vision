import 'dart:io';

import 'package:flutter/material.dart';
import 'package:vision/mode/local/local_app.dart';

Future<Widget> makeFlowApp() {
  final path = Platform.environment['GLUE_PATH'] ?? "";
  return makeLocalApp(title: 'Flow', codePath: path);
  // return makeLiveApp(title: 'Flow', host: '192.168.11.101', port: 3005);
}
