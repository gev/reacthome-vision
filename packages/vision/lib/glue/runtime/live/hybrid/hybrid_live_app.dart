import 'package:flutter/widgets.dart';
import 'package:flutterpi_gstreamer_video_player/flutterpi_gstreamer_video_player.dart';
import 'package:glue/ir.dart';
import 'package:vision/glue/discovery_store.dart';
import 'package:vision/glue/runtime/app.dart';
import 'package:vision/glue/runtime/live/hybrid/hybrid_live_scope.dart';
import 'package:vision/widgets/vision_app.dart';

Future<Widget> makeHybridLiveApp({
  required String title,
  required String url,
  Ir args = const IrVoid(),
}) async {
  final discoveryStore = DiscoveryStore();
  WidgetsFlutterBinding.ensureInitialized();
  FlutterpiVideoPlayer.registerWith();
  // MediaKit.ensureInitialized();
  await App.init();
  return makeHybridLiveScope(
    path: App.appRoot,
    getUrl: () => url,
    discoveryStore: discoveryStore,
    child: VisionApp(title: title, args: args),
  );
}
