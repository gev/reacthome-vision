import 'package:flutter/material.dart';
import 'package:vision/glue/runtime/local/static/static_local_app.dart';

Future<Widget> makeFlowApp() {
  // final codePath = Platform.environment['GLUE_PATH'] ?? "";
  // return makeDynamicLocalApp(title: 'Flow', codePath: codePath);
  return makeStaticLocalApp(title: 'Flow', package: 'flow/glue');
}
