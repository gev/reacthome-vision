import 'package:flutter/widgets.dart';
import 'package:glue/ir.dart';
import 'package:vision/scope_factory.dart';

Future<Widget> makeLocalApp({
  required String title,
  required String codePath,
  Ir args = const IrVoid(),
}) async {
  WidgetsFlutterBinding.ensureInitialized();
  await ScopeFactory.init();
  return ScopeFactory.makeLocalApp(
    title: title,
    codePath: codePath,
    args: args,
  );
}
