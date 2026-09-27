import 'package:vision/connection/connection_monitor.dart';
import 'package:vision/connection/connection_status.dart';

class Connection {
  final monitor = makeConnectionMonitor();
  final OnConnectionStatusChange onConnectionStatusChange;

  Connection({required this.onConnectionStatusChange});

  void onStatusChange(ConnectionStatus newStatus) {
    monitor.value = newStatus;
    onConnectionStatusChange(newStatus);
  }

  void dispose() {
    monitor.dispose();
  }
}
