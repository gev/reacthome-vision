import 'package:glue/module.dart';
import 'package:vision/connection/hybrid_connection.dart';
import 'package:vision/glue/runtime/live/hybrid/lib/hybrid_connectivity_module.dart';
import 'package:vision/glue/runtime/live/live_orchestrator.dart';
import 'package:vision/url.dart';

class HybridLiveOrchestrator extends LiveOrchestrator {
  final GetUrl _getUrl;

  late final HybridConnection _hybridConnection = HybridConnection(
    getUrl: _getUrl,
    sink: inbound,
    source: outbound.stream,
    onStatusChanged: (status) {
      if (status == .connected) {
        resubscribe();
      }
    },
  );

  HybridLiveOrchestrator({
    required this._getUrl,
    required super.path,
    required super.discoveryStore,
  });

  @override
  ModuleInfo get connectivityModule =>
      hybridConnectivityModule(_hybridConnection.directConnection.monitor);

  @override
  void dispose() {
    _hybridConnection.dispose();
    super.dispose();
  }
}
