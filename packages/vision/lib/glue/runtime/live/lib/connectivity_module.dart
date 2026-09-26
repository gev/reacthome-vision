import 'package:glue/module.dart';
import 'package:vision/connection/connection_monitor.dart';
import 'package:vision/glue/runtime/live/lib/connectivity/connection_monitor.dart';
import 'package:vision/glue/runtime/live/lib/connectivity/connection_status.dart';

ModuleInfo connectivityModule(ConnectionMonitor monitor) {
  return nativeModule('ffi.vision.connectivity', [
    ('local-connection-monitor', localConnectionMonitor(monitor)),
    ('connection-status', connectionStatus),
  ]);
}
