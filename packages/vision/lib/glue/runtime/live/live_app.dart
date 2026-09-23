import 'package:flutter/widgets.dart';
import 'package:glue/ir.dart';
import 'package:vision/glue/discovery_store.dart';
import 'package:vision/glue/runtime/live/live_scope.dart';
import 'package:vision/glue/runtime/scope_factory.dart';
import 'package:vision/widgets/vision_app.dart';

Future<Widget> makeLiveApp({
  required String title,
  required String url,
  Ir args = const IrVoid(),
}) async {
  final discoveryStore = DiscoveryStore();
  WidgetsFlutterBinding.ensureInitialized();
  await ScopeFactory.init();
  return makeLiveScope(
    path: ScopeFactory.appRoot,
    url: url,
    discoveryStore: discoveryStore,
    child: VisionApp(title: title, args: args),
  );
}
