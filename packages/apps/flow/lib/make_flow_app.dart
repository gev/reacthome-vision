import 'package:flutter/material.dart';
import 'package:vision/glue/runtime/local/static/static_local_app.dart';

Future<Widget> makeFlowApp() {
  return makeStaticLocalApp(title: 'Flow', package: 'flow/glue');
}
