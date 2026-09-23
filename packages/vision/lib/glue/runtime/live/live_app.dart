import 'package:flutter/widgets.dart';
import 'package:glue/ir.dart';
import 'package:vision/glue/discovery_store.dart';
import 'package:vision/glue/runtime/app.dart';
import 'package:vision/glue/runtime/live/live_scope.dart';
import 'package:vision/widgets/vision_app.dart';

Future<Widget> makeLiveApp({
  required String title,
  required String url,
  Ir args = const IrVoid(),
}) async {
  final discoveryStore = DiscoveryStore();
  WidgetsFlutterBinding.ensureInitialized();
  await App.init();
  return makeLiveScope(
    path: App.appRoot,
    url: url,
    discoveryStore: discoveryStore,
    child: VisionApp(title: title, args: args),
  );
}
