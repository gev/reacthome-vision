import 'package:flutter/material.dart';
import 'package:vision/glue/glue_evaluator.dart';
import 'package:vision/glue/widgets/glue_widget.dart';
import 'package:vision/websocket/websocket_client.dart';
import 'package:vision/widgets/screen.dart';
import 'package:vision/widgets/theme.dart';

class VisionApp extends StatelessWidget {
  final String title;
  final WebSocketClient client;
  final GlueEvaluator evaluator;

  const VisionApp({
    required this.client,
    required this.title,
    required this.evaluator,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: title,
      themeMode: ThemeMode.system,
      theme: makeTheme(Colors.blue, Brightness.light),
      darkTheme: makeTheme(Colors.blue, Brightness.dark),
      // home: Screen(client: client, child: Splash(title)),
      home: Screen(
        client: client,
        child: GlueWidget(evaluator: evaluator, glue: _main),
      ),
    );
  }
}

final String _main = '''
  (listen 
    (lookup store.cache "main" placeholder)
    (lambda (main) (main ())))
''';
