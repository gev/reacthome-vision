import 'package:flutter/material.dart';
import 'package:vision/glue/discovery_store.dart';
import 'package:vision/glue/runtime/app.dart';
import 'package:vision/glue/runtime/live/direct/direct_live_scope.dart';
import 'package:vision/widgets/vision_app.dart';

Future<Widget> makeDirectLiveApp({
  required String title,
  required String url,
  Color? seedColor,
  DynamicSchemeVariant? dynamicSchemeVariant,
  VisualDensity? visualDensity,
}) async {
  final discoveryStore = DiscoveryStore();
  await App.init(discoveryStore);
  return makeDirectLiveScope(
    path: App.appRoot,
    url: url,
    discoveryStore: discoveryStore,
    child: VisionApp(
      title: title,
      seedColor: seedColor,
      dynamicSchemeVariant: dynamicSchemeVariant,
      visualDensity: visualDensity,
    ),
  );
}
