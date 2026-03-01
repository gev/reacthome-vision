import 'package:flutter/material.dart';
import 'package:vision/websocket/websocket_client.dart';
import 'package:vision/widgets/screen.dart';
import 'package:vision/widgets/splash.dart';
import 'package:vision/widgets/theme.dart';

class VisionApp extends StatelessWidget {
  final String title;
  final WebSocketClient client;
  const VisionApp({required this.client, required this.title, super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: title,
      themeMode: ThemeMode.system,
      theme: makeTheme(Colors.blue, Brightness.light),
      darkTheme: makeTheme(Colors.blue, Brightness.dark),
      home: Screen(client: client, child: Splash(title)),
    );
  }
}
