import 'package:flutter/widgets.dart';
import 'package:glue/ir.dart';
import 'package:vision/glue/discovery_store.dart';
import 'package:vision/scope_factory.dart';

Future<Widget> makeLiveApp({
  required String title,
  required String url,
  Ir args = const IrVoid(),
}) async {
  final discoveryStore = DiscoveryStore();
  WidgetsFlutterBinding.ensureInitialized();
  await ScopeFactory.init();
  return ScopeFactory.makeLiveApp(
    title: title,
    url: url,
    discoveryStore: discoveryStore,
    args: args,
  );
}
