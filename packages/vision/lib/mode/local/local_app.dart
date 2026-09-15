import 'package:flutter/widgets.dart';
import 'package:vision/scope_factory.dart';

Future<Widget> makeLocalApp({
  required String title,
  required String codePath,
}) async {
  WidgetsFlutterBinding.ensureInitialized();
  await ScopeFactory.init();
  return ScopeFactory.makeLocalApp(title: title, codePath: codePath);
}
