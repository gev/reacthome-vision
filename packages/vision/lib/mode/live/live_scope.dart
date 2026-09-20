import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:vision/mode/live/live_orchestrator.dart';
import 'package:vision/scope.dart';

Widget makeLiveScope({
  required String uri,
  required Directory path,
  required Widget child,
  Key? key,
}) {
  final orchestrator = LiveOrchestrator(path: path, uri: uri);
  return Scope(
    key: key,
    log: orchestrator.log,
    reactiveRuntime: orchestrator.reactiveRuntime,
    child: child,
  );
}
