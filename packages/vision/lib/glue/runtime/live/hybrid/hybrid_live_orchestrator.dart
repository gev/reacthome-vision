import 'package:glue/module.dart';
import 'package:vision/connection/direct_connection.dart';
import 'package:vision/glue/runtime/live/hybrid/lib/hybrid_connectivity_module.dart';
import 'package:vision/glue/runtime/live/live_orchestrator.dart';
import 'package:vision/url.dart';

class HybridLiveOrchestrator extends LiveOrchestrator {
  final GetUrl _getUrl;

  late final DirectConnection _directConnection = DirectConnection(
    getUrl: _getUrl,
    sink: inbound,
    source: outbound.stream,
    resubscribe: resubscribe,
  );

  HybridLiveOrchestrator({
    required this._getUrl,
    required super.path,
    required super.discoveryStore,
  });

  @override
  ModuleInfo get connectivityModule =>
      hybridConnectivityModule(_directConnection.monitor);

  @override
  void dispose() {
    _directConnection.dispose();
    super.dispose();
  }
}
