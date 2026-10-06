import 'dart:io';

import 'package:flutter/material.dart';
import 'package:vision/glue/runtime/local/dynamic/dynamic_local_app.dart';
import 'package:vision/glue/runtime/local/static/static_local_app.dart';

Future<Widget> makeFlowApp({
  Color? seedColor,
  DynamicSchemeVariant? dynamicSchemeVariant,
  VisualDensity? visualDensity,
}) {
  final codePath = Platform.environment['GLUE_PATH'];
  return codePath != null
      ? makeDynamicLocalApp(
          title: 'Flow',
          seedColor: seedColor,
          dynamicSchemeVariant: dynamicSchemeVariant,
          visualDensity: visualDensity,
          codePath: codePath,
        )
      : makeStaticLocalApp(
          title: 'Flow',
          seedColor: seedColor,
          dynamicSchemeVariant: dynamicSchemeVariant,
          visualDensity: visualDensity,
          package: 'flow/glue',
        );
}
