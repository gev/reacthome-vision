import 'package:glue/module.dart';
import 'package:vision/glue/lib/applets/live_applet.dart';
import 'package:vision/glue/lib/applets/local_applet.dart';

ModuleInfo widgetsModule = nativeModule('ffi.vision.applets', [
  ('live-applet', liveApplet),
  ('local-applet', localApplet),
]);
