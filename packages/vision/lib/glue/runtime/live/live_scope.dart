import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:vision/glue/discovery_store.dart';
import 'package:vision/glue/runtime/live/live_orchestrator.dart';
import 'package:vision/glue/runtime/scope.dart';

Widget makeLiveScope({
  required String url,
  required Directory path,
  required DiscoveryStore discoveryStore,
  required Widget child,
  Key? key,
}) {
  final orchestrator = LiveOrchestrator(
    path: path,
    url: url,
    discoveryStore: discoveryStore,
  );
  return Scope(
    key: key,
    log: orchestrator.log,
    reactiveRuntime: orchestrator.reactiveRuntime,
    child: child,
  );
}
