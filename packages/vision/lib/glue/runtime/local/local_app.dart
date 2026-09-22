import 'package:flutter/widgets.dart';
import 'package:glue/ir.dart';
import 'package:vision/discovery/discovery.dart';
import 'package:vision/glue/discovery_store.dart';
import 'package:vision/scope_factory.dart';

Future<Widget> makeLocalApp({
  required String title,
  required String codePath,
  Ir args = const IrVoid(),
}) async {
  WidgetsFlutterBinding.ensureInitialized();
  final discoveryStore = DiscoveryStore();
  startDiscovery(
    onAnnounce: (message, address) {
      print(address);
      print(message);
    },
  );
  await ScopeFactory.init();
  return ScopeFactory.makeLocalApp(
    title: title,
    codePath: codePath,
    discoveryStore: discoveryStore,
    args: args,
  );
}
