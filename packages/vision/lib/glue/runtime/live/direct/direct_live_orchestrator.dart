import 'package:glue/module.dart';
import 'package:vision/connection/direct_connection.dart';
import 'package:vision/glue/runtime/live/direct/lib/direct_connectivity_module.dart';
import 'package:vision/glue/runtime/live/live_orchestrator.dart';

class DirectLiveOrchestrator extends LiveOrchestrator {
  late final DirectConnection _connection;

  DirectLiveOrchestrator({
    required String url,
    required super.path,
    required super.discoveryStore,
  }) {
    _connection = DirectConnection(
      getUrl: () => url,
      sink: inbound,
      source: outbound.stream,
      onConnectionStatusChange: onStatusChange,
    );
  }

  @override
  ModuleInfo get connectivityModule =>
      directConnectivityModule(_connection.monitor);

  @override
  void dispose() {
    _connection.dispose();
    super.dispose();
  }
}
