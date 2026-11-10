import 'package:flutter/widgets.dart';
import 'package:glue/ir.dart';
import 'package:vision/glue/discovery_store.dart';
import 'package:vision/glue/runtime/app.dart';
import 'package:vision/glue/runtime/applet_registry.dart';
import 'package:vision/glue/runtime/live/hybrid/hybrid_live_scope.dart';
import 'package:vision/widgets/vision_applet.dart';

Widget makeHybridLiveApplet({
  required String id,
  required String title,
  required DiscoveryStore discoveryStore,
  required Ir args,
  Key? key,
}) => AppletRegistry.registerApplet(
  id,
  () => makeHybridLiveScope(
    key: key,
    getUrl: () => discoveryStore.url(id),
    path: App.appletRoot(id),
    discoveryStore: discoveryStore,
    child: VisionApplet(title: title, args: args),
  ),
);
