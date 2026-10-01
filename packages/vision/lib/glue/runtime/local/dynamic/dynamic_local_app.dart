import 'package:flutter/material.dart';
import 'package:glue/ir.dart';
import 'package:vision/glue/discovery_store.dart';
import 'package:vision/glue/runtime/app.dart';
import 'package:vision/glue/runtime/local/dynamic/dynamic_local_scope.dart';
import 'package:vision/widgets/vision_app.dart';

Future<Widget> makeDynamicLocalApp({
  required String title,
  required String codePath,
  Ir args = const IrVoid(),
}) async {
  final discoveryStore = DiscoveryStore();
  await App.init(discoveryStore);
  return makeDynamicLocalScope(
    path: App.appRoot,
    codePath: codePath,
    discoveryStore: discoveryStore,
    child: VisionApp(title: title, args: args),
  );
}
