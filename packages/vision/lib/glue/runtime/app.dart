import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:media_kit/media_kit.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:video_player_media_kit/video_player_media_kit.dart';
import 'package:vision/glue/discovery_store.dart';
import 'package:vision/glue/runtime/local/discovery.dart';

class App {
  App._();

  static late String _root;

  static Directory get appRoot =>
      Directory(p.join(_root, 'app'))..createSync(recursive: true);

  static Directory appletRoot(String id) =>
      Directory(p.join(_root, 'applet', id))..createSync(recursive: true);

  static Future<void> init(DiscoveryStore store) async {
    WidgetsFlutterBinding.ensureInitialized();
    // FlutterpiVideoPlayer.registerWith();
    MediaKit.ensureInitialized();
    VideoPlayerMediaKit.ensureInitialized(macOS: true);
    final dir = await getApplicationSupportDirectory();
    runDiscovery(store);
    _root = dir.path;
  }
}
