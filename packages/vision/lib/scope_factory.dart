import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:vision/mode/live/live_scope.dart';
import 'package:vision/mode/local/local_scope.dart';
import 'package:vision/widgets/vision_app.dart';
import 'package:vision/widgets/vision_applet.dart';

class ScopeFactory {
  ScopeFactory._();

  static late String _root;

  static Directory get _appRoot =>
      Directory(p.join(_root, 'app'))..createSync(recursive: true);

  static Directory _appletRoot(String id) =>
      Directory(p.join(_root, 'applet', id))..createSync(recursive: true);

  static Future<void> init() async {
    final dir = await getApplicationSupportDirectory();
    _root = dir.path;
  }

  static Widget makeLiveApp({
    required String title,
    required String host,
    required int port,
  }) {
    return makeLiveScope(
      path: _appRoot,
      host: host,
      port: port,
      child: VisionApp(title: title),
    );
  }

  static Widget makeLocalApp({
    required String title,
    required String codePath,
  }) {
    return makeLocalScope(
      path: _appRoot,
      codePath: codePath,
      child: VisionApp(title: title),
    );
  }

  static Widget makeLiveApplet({
    required String id,
    required String title,
    required String host,
    required int port,
  }) {
    return makeLiveScope(
      path: _appletRoot(id),
      host: host,
      port: port,
      child: VisionApplet(title: title),
    );
  }

  static Widget makeLocalApplet({
    required String id,
    required String title,
    required String codePath,
  }) {
    return makeLocalScope(
      path: _appletRoot(id),
      codePath: codePath,
      child: VisionApplet(title: title),
    );
  }
}
