import 'package:glue/module.dart';
import 'package:vision/glue/runtime/live/lib/connectivity/connection_monitor.dart';
import 'package:vision/glue/runtime/live/lib/connectivity/connection_state.dart';
import 'package:vision/websocket/connection_monitor.dart';

ModuleInfo connectivityModule(ConnectionMonitor monitor) {
  return nativeModule('ffi.vision.connectivity', [
    ('local-connection-monitor', localConnectionMonitor(monitor)),
    ('connection-status', connectionStatus),
  ]);
}
