import 'package:glue/module.dart';
import 'package:vision/connection/connection_monitor.dart';
import 'package:vision/connectivity/relay_connection_monitor.dart';
import 'package:vision/glue/runtime/live/lib/connectivity/connection_status.dart';

ModuleInfo connectivityModule(ConnectionMonitor monitor) {
  return nativeModule('ffi.vision.connectivity', [
    ('connection-status', connectionStatus),
    ('relay-connection-monitor', relayConnectionMonitor(monitor)),
  ]);
}
