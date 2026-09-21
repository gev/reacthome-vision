import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:glue/ir.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:vision/glue/runtime/live/live_scope.dart';
import 'package:vision/glue/runtime/local/local_scope.dart';
import 'package:vision/widgets/vision_app.dart';
import 'package:vision/widgets/vision_applet.dart';

class ScopeFactory {
  ScopeFactory._();

  static late String _root;

  static final Map<String, Widget> _pool = {};

  static Directory get _appRoot =>
      Directory(p.join(_root, 'app'))..createSync(recursive: true);

  static Directory _appletRoot(String id) =>
      Directory(p.join(_root, 'applet', id))..createSync(recursive: true);

  static Future<void> init() async {
    final dir = await getApplicationSupportDirectory();
    _root = dir.path;
  }

  static Widget makeLiveApp({
    required String url,
    required String title,
    required Ir args,
  }) {
    return makeLiveScope(
      path: _appRoot,
      url: url,
      child: VisionApp(title: title, args: args),
    );
  }

  static Widget makeLocalApp({
    required String title,
    required String codePath,
    required Ir args,
  }) {
    return makeLocalScope(
      path: _appRoot,
      codePath: codePath,
      child: VisionApp(title: title, args: args),
    );
  }

  static Widget _registerApplet(String id, {required Widget applet}) {
    _pool[id] = applet;
    return applet;
  }

  static Widget makeLiveApplet({
    required String id,
    required String title,
    required String url,
    required Ir args,
    Key? key,
  }) {
    return _pool[id] ??
        _registerApplet(
          id,
          applet: makeLiveScope(
            key: key,
            path: _appletRoot(id),
            url: url,
            child: VisionApplet(title: title, args: args),
          ),
        );
  }

  static Widget makeLocalApplet({
    required String id,
    required String title,
    required String codePath,
    required Ir args,
    Key? key,
  }) {
    return _pool[id] ??
        _registerApplet(
          id,
          applet: makeLocalScope(
            key: key,
            path: _appletRoot(id),
            codePath: codePath,
            child: VisionApplet(title: title, args: args),
          ),
        );
  }
}
