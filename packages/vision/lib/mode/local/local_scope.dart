import 'package:flutter/widgets.dart';
import 'package:path_provider/path_provider.dart';
import 'package:vision/mode/local/local_orchestrator.dart';
import 'package:vision/scope.dart';

Future<Widget> makeLocalScope({
  required String codePath,
  required Widget child,
}) async {
  WidgetsFlutterBinding.ensureInitialized();
  final orchestrator = LocalOrchestrator(
    path: await getApplicationSupportDirectory(),
    codePath: codePath,
  );
  return Scope(
    log: orchestrator.log,
    reactiveRuntime: orchestrator.reactiveRuntime,
    child: child,
  );
}
