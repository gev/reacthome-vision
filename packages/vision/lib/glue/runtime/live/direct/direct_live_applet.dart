import 'package:flutter/widgets.dart';
import 'package:glue/ir.dart';
import 'package:vision/glue/discovery_store.dart';
import 'package:vision/glue/runtime/app.dart';
import 'package:vision/glue/runtime/applet_registry.dart';
import 'package:vision/glue/runtime/live/direct/direct_live_scope.dart';
import 'package:vision/widgets/vision_applet.dart';

Widget makeDirectLiveApplet({
  required String id,
  required String url,
  required String title,
  required DiscoveryStore discoveryStore,
  required Ir args,
  Key? key,
}) => AppletRegistry.registerApplet(
  id,
  () => makeDirectLiveScope(
    key: key,
    url: url,
    path: App.appletRoot(id),
    discoveryStore: discoveryStore,
    child: VisionApplet(title: title, args: args),
  ),
);
