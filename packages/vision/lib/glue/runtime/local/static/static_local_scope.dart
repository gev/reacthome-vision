import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:vision/glue/discovery_store.dart';
import 'package:vision/glue/runtime/local/static/static_local_orchestrator.dart';
import 'package:vision/glue/runtime/scope.dart';

Widget makeStaticLocalScope({
  required Directory path,
  required String package,
  required DiscoveryStore discoveryStore,
  required Widget child,
  Key? key,
}) {
  final orchestrator = StaticLocalOrchestrator(
    path: path,
    package: package,
    discoveryStore: discoveryStore,
  );
  return Scope(
    key: key,
    log: orchestrator.log,
    reactiveRuntime: orchestrator.reactiveRuntime,
    child: child,
  );
}
