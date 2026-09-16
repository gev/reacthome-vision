import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:vision/mode/live/live_orchestrator.dart';
import 'package:vision/scope.dart';

Widget makeLiveScope({
  required Directory path,
  required String host,
  required int port,
  required Widget child,
  Key? key,
}) {
  final orchestrator = LiveOrchestrator(path: path, host: host, port: port);
  return Scope(
    key: key,
    log: orchestrator.log,
    reactiveRuntime: orchestrator.reactiveRuntime,
    child: child,
  );
}
