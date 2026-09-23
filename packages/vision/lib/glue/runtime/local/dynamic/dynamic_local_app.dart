import 'package:flutter/material.dart';
import 'package:glue/ir.dart';
import 'package:media_kit/media_kit.dart';
import 'package:vision/discovery/discovery.dart';
import 'package:vision/glue/discovery_store.dart';
import 'package:vision/scope_factory.dart';

Future<Widget> makeDynamicLocalApp({
  required String title,
  required String codePath,
  Ir args = const IrVoid(),
}) async {
  WidgetsFlutterBinding.ensureInitialized();
  MediaKit.ensureInitialized();
  final discoveryStore = DiscoveryStore();
  startDiscovery(onAnnounce: print);
  await ScopeFactory.init();
  return ScopeFactory.makeDynamicLocalApp(
    title: title,
    codePath: codePath,
    discoveryStore: discoveryStore,
    args: args,
  );
}
