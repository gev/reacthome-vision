import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

class ScopeFactory {
  ScopeFactory._();

  static late String _root;

  static Directory get appRoot =>
      Directory(p.join(_root, 'app'))..createSync(recursive: true);

  static Directory appletRoot(String id) =>
      Directory(p.join(_root, 'applet', id))..createSync(recursive: true);

  static Future<void> init() async {
    final dir = await getApplicationSupportDirectory();
    _root = dir.path;
  }

  static final Map<String, Widget> _pool = {};

  static Widget registerApplet(String id, Widget Function() makeApplet) {
    var widget = _pool[id];
    if (widget == null) {
      widget = makeApplet();
      _pool[id] = widget;
    }
    return widget;
  }
}
