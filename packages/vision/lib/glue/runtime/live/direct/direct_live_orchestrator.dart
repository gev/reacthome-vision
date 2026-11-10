import 'package:glue/module.dart';
import 'package:vision/connection/direct_connection.dart';
import 'package:vision/glue/runtime/live/direct/lib/direct_connectivity_module.dart';
import 'package:vision/glue/runtime/live/live_orchestrator.dart';
import 'package:vision/url.dart';

class DirectLiveOrchestrator extends LiveOrchestrator {
  final GetUrl _getUrl;

  late final DirectConnection _connection = DirectConnection(
    getUrl: _getUrl,
    sink: inbound,
    source: outbound.stream,
    onStatusChanged: resubscribe,
  );

  DirectLiveOrchestrator({
    required this._getUrl,
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
