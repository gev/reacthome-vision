import 'package:flutter/widgets.dart';
import 'package:path_provider/path_provider.dart';
import 'package:vision/mode/live/live_orchestrator.dart';
import 'package:vision/scope.dart';

Future<Widget> makeLiveScope({
  required String host,
  required int port,
  required Widget child,
}) async {
  WidgetsFlutterBinding.ensureInitialized();
  final orchestrator = LiveOrchestrator(
    path: await getApplicationSupportDirectory(),
    host: host,
    port: port,
  );
  return Scope(
    log: orchestrator.log,
    reactiveRuntime: orchestrator.reactiveRuntime,
    child: child,
  );
}
