import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:vision/glue/runtime/live/live_orchestrator.dart';
import 'package:vision/scope.dart';

Widget makeLiveScope({
  required String url,
  required Directory path,
  required Widget child,
  Key? key,
}) {
  final orchestrator = LiveOrchestrator(path: path, url: url);
  return Scope(
    key: key,
    log: orchestrator.log,
    reactiveRuntime: orchestrator.reactiveRuntime,
    child: child,
  );
}
