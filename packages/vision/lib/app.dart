import 'package:flutter/widgets.dart';
import 'package:vision/scope.dart';
import 'package:vision/widgets/vision_app.dart';
import 'package:vision/widgets/vision_scope.dart';

Widget makeApp({
  required String title,
  required String host,
  required int port,
}) {
  return VisionScope(
    scope: Scope(host: host, port: port),
    child: VisionApp(title: title),
  );
}
