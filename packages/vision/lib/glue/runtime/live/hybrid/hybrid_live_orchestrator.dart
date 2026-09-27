import 'package:glue/module.dart';
import 'package:vision/connection/direct_connection.dart';
import 'package:vision/glue/runtime/live/hybrid/lib/hybrid_connectivity_module.dart';
import 'package:vision/glue/runtime/live/live_orchestrator.dart';
import 'package:vision/url.dart';

class HybridLiveOrchestrator extends LiveOrchestrator {
  late final DirectConnection _directConnection;

  HybridLiveOrchestrator({
    required GetUrl getUrl,
    required super.path,
    required super.discoveryStore,
  }) {
    _directConnection = DirectConnection(
      getUrl: getUrl,
      sink: inbound,
      source: outbound.stream,
      onConnectionStatusChange: onStatusChange,
    );
  }

  @override
  ModuleInfo get connectivityModule =>
      hybridConnectivityModule(_directConnection.monitor);

  @override
  void dispose() {
    _directConnection.dispose();
    super.dispose();
  }
}
