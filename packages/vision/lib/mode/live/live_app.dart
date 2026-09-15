import 'package:flutter/widgets.dart';
import 'package:path_provider/path_provider.dart';
import 'package:vision/mode/live/live_scope.dart';
import 'package:vision/widgets/vision_app.dart';

Future<Widget> makeLiveApp({
  required String host,
  required int port,
  required String title,
}) async {
  WidgetsFlutterBinding.ensureInitialized();
  return makeLiveScope(
    path: await getApplicationSupportDirectory(),
    host: host,
    port: port,
    child: VisionApp(title: title),
  );
}
