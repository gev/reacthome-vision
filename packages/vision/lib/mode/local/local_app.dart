import 'package:flutter/widgets.dart';
import 'package:path_provider/path_provider.dart';
import 'package:vision/mode/local/local_scope.dart';
import 'package:vision/widgets/vision_app.dart';

Future<Widget> makeLocalApp({
  required String codePath,
  required String title,
}) async {
  return makeLocalScope(
    path: await getApplicationSupportDirectory(),
    codePath: codePath,
    child: VisionApp(title: title),
  );
}
