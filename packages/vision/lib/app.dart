import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:vision/scope.dart';
import 'package:vision/session/session_orchestrator.dart';
import 'package:vision/widgets/vision_app.dart';

Widget makeApp({
  required String title,
  required String host,
  required int port,
}) {
  final orchestrator = SessionOrchestrator(
    path: Directory('var'),
    host: host,
    port: port,
  );
  return Scope(
    log: orchestrator.log,
    reactiveRuntime: orchestrator.reactiveRuntime,
    session: orchestrator.monitor,
    child: VisionApp(title: title),
  );
}
