import 'package:glue/module.dart';
import 'package:vision/connection/direct_connection.dart';
import 'package:vision/glue/runtime/live/direct/lib/direct_connectivity_module.dart';
import 'package:vision/glue/runtime/live/live_orchestrator.dart';

class DirectLiveOrchestrator extends LiveOrchestrator {
  final String _url;

  late final DirectConnection _connection = DirectConnection(
    getUrl: () => _url,
    sink: inbound,
    source: outbound.stream,
  );

  DirectLiveOrchestrator({
    required this._url,
    required super.path,
    required super.discoveryStore,
  });

  @override
  ModuleInfo get connectivityModule =>
      directConnectivityModule(_connection.monitor);

  @override
  void dispose() {
    _connection.dispose();
    super.dispose();
  }
}
