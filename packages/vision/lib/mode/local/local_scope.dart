import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:vision/mode/local/local_orchestrator.dart';
import 'package:vision/scope.dart';

Widget makeLocalScope({
  required Directory path,
  required String codePath,
  required Widget child,
  Key? key,
}) {
  final orchestrator = LocalOrchestrator(path: path, codePath: codePath);
  return Scope(
    key: key,
    log: orchestrator.log,
    reactiveRuntime: orchestrator.reactiveRuntime,
    child: child,
  );
}
