import 'package:glue/module.dart';
import 'package:vision/connection/connection_monitor.dart';
import 'package:vision/connection/connection_status.dart';
import 'package:vision/connection/direct_connection.dart';
import 'package:vision/glue/runtime/live/direct/lib/direct_connectivity_module.dart';
import 'package:vision/glue/runtime/live/live_orchestrator.dart';

class DirectLiveOrchestrator extends LiveOrchestrator {
  final _monitor = makeConnectionMonitor();

  DirectLiveOrchestrator({
    required String url,
    required super.path,
    required super.discoveryStore,
  }) {
    DirectConnection(
      getUrl: () => url,
      sink: inbound,
      source: outbound.stream,
      onStatusChange: onStatusChange,
    );
  }

  @override
  ModuleInfo get connectivityModule => directConnectivityModule(_monitor);

  @override
  void onStatusChange(ConnectionStatus newState) {
    _monitor.value = newState;
    super.onStatusChange(newState);
  }

  @override
  void dispose() {
    _monitor.dispose();
    super.dispose();
  }
}
