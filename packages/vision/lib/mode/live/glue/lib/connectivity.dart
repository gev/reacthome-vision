import 'package:glue/module.dart';
import 'package:vision/mode/live/glue/lib/connectivity/session_monitor.dart';
import 'package:vision/mode/live/glue/lib/connectivity/session_state.dart';
import 'package:vision/mode/live/session/session_monitor.dart';

ModuleInfo connectivityModule(SessionMonitor monitor) {
  return nativeModule('ffi.vision.connectivity', [
    ('local-session-monitor', localSessionMonitor(monitor)),
    ('session-state', sessionState),
  ]);
}
