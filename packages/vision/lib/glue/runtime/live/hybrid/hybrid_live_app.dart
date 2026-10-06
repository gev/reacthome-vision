import 'package:flutter/material.dart';
import 'package:vision/glue/discovery_store.dart';
import 'package:vision/glue/runtime/app.dart';
import 'package:vision/glue/runtime/live/hybrid/hybrid_live_scope.dart';
import 'package:vision/widgets/vision_app.dart';

Future<Widget> makeHybridLiveApp({
  required String title,
  required String url,
  Color? seedColor,
  DynamicSchemeVariant? dynamicSchemeVariant,
  VisualDensity? visualDensity,
}) async {
  final discoveryStore = DiscoveryStore();
  await App.init(discoveryStore);
  return makeHybridLiveScope(
    path: App.appRoot,
    getUrl: () => url,
    discoveryStore: discoveryStore,
    child: VisionApp(
      title: title,
      seedColor: seedColor,
      dynamicSchemeVariant: dynamicSchemeVariant,
      visualDensity: visualDensity,
    ),
  );
}
