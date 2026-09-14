import 'dart:io';

import 'package:glue/module.dart';
import 'package:vision/glue/lib/applets/live_applet.dart';
import 'package:vision/glue/lib/applets/local_applet.dart';

ModuleInfo appletsModule(Directory path) {
  return nativeModule('ffi.vision.applets', [
    ('live-applet', liveApplet(path)),
    ('local-applet', localApplet(path)),
  ]);
}
