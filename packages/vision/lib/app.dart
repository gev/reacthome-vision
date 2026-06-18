import 'package:flutter/widgets.dart';
import 'package:path_provider/path_provider.dart';
import 'package:vision/scope.dart';
import 'package:vision/session/session_orchestrator.dart';
import 'package:vision/widgets/vision_app.dart';

Future<Widget> makeApp({
  required String title,
  required String host,
  required int port,
}) async {
  final orchestrator = SessionOrchestrator(
    path: await getApplicationSupportDirectory(),
    tmp: await getTemporaryDirectory(),
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
