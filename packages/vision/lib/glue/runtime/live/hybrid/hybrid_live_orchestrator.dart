import 'package:glue/module.dart';
import 'package:vision/connection/connection_monitor.dart';
import 'package:vision/connection/connection_status.dart';
import 'package:vision/connection/direct_connection.dart';
import 'package:vision/glue/runtime/live/hybrid/lib/hybrid_connectivity_module.dart';
import 'package:vision/glue/runtime/live/live_orchestrator.dart';
import 'package:vision/url.dart';

class HybridLiveOrchestrator extends LiveOrchestrator {
  final _monitor = makeConnectionMonitor();

  HybridLiveOrchestrator({
    required GetUrl getUrl,
    required super.path,
    required super.discoveryStore,
  }) {
    DirectConnection(
      getUrl: getUrl,
      sink: inbound,
      source: outbound.stream,
      onStatusChange: onStatusChange,
    );
  }

  @override
  ModuleInfo get connectivityModule => hybridConnectivityModule(_monitor);

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
