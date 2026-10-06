import 'package:flutter/material.dart';
import 'package:vision/glue/discovery_store.dart';
import 'package:vision/glue/runtime/app.dart';
import 'package:vision/glue/runtime/local/static/static_local_scope.dart';
import 'package:vision/widgets/vision_app.dart';

Future<Widget> makeStaticLocalApp({
  required String title,
  required String package,
}) async {
  final discoveryStore = DiscoveryStore();
  await App.init(discoveryStore);
  return makeStaticLocalScope(
    path: App.appRoot,
    package: package,
    discoveryStore: discoveryStore,
    child: VisionApp(title: title),
  );
}
