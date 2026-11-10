import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:vision/glue/discovery_store.dart';
import 'package:vision/glue/runtime/live/hybrid/hybrid_live_orchestrator.dart';
import 'package:vision/glue/runtime/scope.dart';
import 'package:vision/url.dart';

Widget makeHybridLiveScope({
  required GetUrl getUrl,
  required Directory path,
  required DiscoveryStore discoveryStore,
  required Widget child,
  Key? key,
}) {
  final orchestrator = HybridLiveOrchestrator(
    getUrl: getUrl,
    path: path,
    discoveryStore: discoveryStore,
  );
  return Scope(
    key: key,
    log: orchestrator.log,
    reactiveRuntime: orchestrator.reactiveRuntime,
    child: child,
  );
}
