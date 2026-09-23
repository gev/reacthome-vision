import 'package:flutter/widgets.dart';
import 'package:glue/ir.dart';
import 'package:vision/glue/discovery_store.dart';
import 'package:vision/glue/runtime/live/live_scope.dart';
import 'package:vision/glue/runtime/scope_factory.dart';
import 'package:vision/widgets/vision_applet.dart';

Widget makeLiveApplet({
  required String id,
  required String title,
  required String url,
  required DiscoveryStore discoveryStore,
  required Ir args,
  Key? key,
}) => ScopeFactory.registerApplet(
  id,
  () => makeLiveScope(
    key: key,
    path: ScopeFactory.appletRoot(id),
    url: url,
    discoveryStore: discoveryStore,
    child: VisionApplet(title: title, args: args),
  ),
);
