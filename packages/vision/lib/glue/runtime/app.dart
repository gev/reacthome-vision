import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

class App {
  App._();

  static late String _root;

  static Directory get appRoot =>
      Directory(p.join(_root, 'app'))..createSync(recursive: true);

  static Directory appletRoot(String id) =>
      Directory(p.join(_root, 'applet', id))..createSync(recursive: true);

  static Future<void> init() async {
    final dir = await getApplicationSupportDirectory();
    _root = dir.path;
  }
}
