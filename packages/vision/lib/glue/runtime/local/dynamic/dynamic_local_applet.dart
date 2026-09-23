import 'package:flutter/widgets.dart';
import 'package:glue/ir.dart';
import 'package:vision/glue/discovery_store.dart';
import 'package:vision/glue/runtime/local/dynamic/dynamic_local_scope.dart';
import 'package:vision/glue/runtime/scope_factory.dart';
import 'package:vision/widgets/vision_applet.dart';

Widget makeDynamicLocalApplet({
  required String id,
  required String title,
  required String codePath,
  required DiscoveryStore discoveryStore,
  required Ir args,
  Key? key,
}) => ScopeFactory.registerApplet(
  id,
  () => makeDynamicLocalScope(
    key: key,
    path: ScopeFactory.appletRoot(id),
    codePath: codePath,
    discoveryStore: discoveryStore,
    child: VisionApplet(title: title, args: args),
  ),
);
