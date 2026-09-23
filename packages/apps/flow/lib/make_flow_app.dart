import 'dart:io';

import 'package:flutter/material.dart';
import 'package:vision/glue/runtime/local/dynamic/dynamic_local_app.dart';
import 'package:vision/glue/runtime/local/static/static_local_app.dart';

Future<Widget> makeFlowApp() {
  final codePath = Platform.environment['GLUE_PATH'];
  return codePath != null
      ? makeDynamicLocalApp(title: 'Flow', codePath: codePath)
      : makeStaticLocalApp(title: 'Flow', package: 'flow/glue');
}
