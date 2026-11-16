import 'package:uuid/uuid.dart';
import 'package:vision/connection/connection_monitor.dart';
import 'package:vision/connection/connection_status.dart';

class Connection {
  final UuidValue peer = Uuid().v4obj();
  final monitor = makeConnectionMonitor();

  void setStatus(ConnectionStatus newStatus) {
    monitor.value = newStatus;
  }

  void dispose() {
    monitor.dispose();
  }
}
