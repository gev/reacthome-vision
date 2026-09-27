import 'package:vision/connection/connection_monitor.dart';
import 'package:vision/connection/connection_status.dart';

class Connection {
  final monitor = makeConnectionMonitor();

  void onStatusChange(ConnectionStatus newStatus) {
    monitor.value = newStatus;
  }

  void dispose() {
    monitor.dispose();
  }
}
