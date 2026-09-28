import 'package:vision/connection/connection_monitor.dart';
import 'package:vision/connection/connection_status.dart';

class Connection {
  final monitor = makeConnectionMonitor();
  final void Function() resubscribe;

  Connection({required this.resubscribe});

  void onStatusChanged(ConnectionStatus newStatus) {
    monitor.value = newStatus;
    if (newStatus == .connected) {
      resubscribe();
    }
  }

  void dispose() {
    monitor.dispose();
  }
}
