import 'package:glue/module.dart';
import 'package:vision/connection/connection_monitor.dart';
import 'package:vision/glue/lib/connectivity/connection_status.dart';
import 'package:vision/glue/runtime/live/direct/lib/connectivity/direct_connection_monitor.dart';

ModuleInfo connectivityModule(ConnectionMonitor monitor) {
  return nativeModule('ffi.vision.connectivity', [
    ('connection-status', connectionStatus),
    ('direct-connection-monitor', directConnectionMonitor(monitor)),
  ]);
}
