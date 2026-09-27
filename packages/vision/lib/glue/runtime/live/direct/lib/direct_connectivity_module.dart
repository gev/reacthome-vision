import 'package:glue/module.dart';
import 'package:vision/connection/connection_monitor.dart';
import 'package:vision/glue/lib/connectivity/connection_monitor.dart';
import 'package:vision/glue/lib/connectivity/connection_status.dart';

ModuleInfo directConnectivityModule(ConnectionMonitor directConnectionMonitor) {
  return nativeModule('ffi.vision.connectivity', [
    ('connection-status', connectionStatus),
    ('direct-connection-monitor', connectionMonitor(directConnectionMonitor)),
  ]);
}
