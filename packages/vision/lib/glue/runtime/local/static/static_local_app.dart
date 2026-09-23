import 'package:flutter/material.dart';
import 'package:glue/ir.dart';
import 'package:media_kit/media_kit.dart';
import 'package:vision/glue/discovery_store.dart';
import 'package:vision/glue/runtime/app.dart';
import 'package:vision/glue/runtime/local/discovery.dart';
import 'package:vision/glue/runtime/local/static/static_local_scope.dart';
import 'package:vision/widgets/vision_app.dart';

Future<Widget> makeStaticLocalApp({
  required String title,
  required String package,
  Ir args = const IrVoid(),
}) async {
  WidgetsFlutterBinding.ensureInitialized();
  MediaKit.ensureInitialized();
  await App.init();
  final discoveryStore = DiscoveryStore();
  runDiscovery(discoveryStore);
  return makeStaticLocalScope(
    path: App.appRoot,
    package: package,
    discoveryStore: discoveryStore,
    child: VisionApp(title: title, args: args),
  );
}
