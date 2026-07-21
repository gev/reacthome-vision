import 'package:flutter/widgets.dart';
import 'package:vision/mode/local/local_orchestrator.dart';
import 'package:vision/scope.dart';
import 'package:vision/widgets/vision_app.dart';

Future<Widget> makeLocalApp({
  required String title,
  required String path,
}) async {
  final orchestrator = LocalOrchestrator(path: path);
  return Scope(
    log: orchestrator.log,
    reactiveRuntime: orchestrator.reactiveRuntime,
    child: VisionApp(title: title),
  );
}
