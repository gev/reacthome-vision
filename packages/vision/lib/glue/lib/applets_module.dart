import 'package:glue/module.dart';
import 'package:vision/glue/discovery_store.dart';
import 'package:vision/glue/lib/applets/live_applet.dart';
import 'package:vision/glue/lib/applets/local_applet.dart';

ModuleInfo appletsModule(DiscoveryStore store) {
  return nativeModule('ffi.vision.applets', [
    ('live-applet', liveApplet(store)),
    ('local-applet', localApplet(store)),
  ]);
}
