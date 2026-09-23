import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:vision/glue/discovery_store.dart';
import 'package:vision/glue/runtime/local/dynamic/dynamic_local_orchestrator.dart';
import 'package:vision/scope.dart';

Widget makeDynamicLocalScope({
  required Directory path,
  required String codePath,
  required DiscoveryStore discoveryStore,
  required Widget child,
  Key? key,
}) {
  final orchestrator = DynamicLocalOrchestrator(
    path: path,
    codePath: codePath,
    discoveryStore: discoveryStore,
  );
  return Scope(
    key: key,
    log: orchestrator.log,
    reactiveRuntime: orchestrator.reactiveRuntime,
    child: child,
  );
}
