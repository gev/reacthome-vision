import 'package:flutter/material.dart';
import 'package:vision/websocket/websocket_client.dart';
import 'package:vision/widgets/statusbar.dart';

class Screen extends StatelessWidget {
  final WebSocketClient client;
  final Widget child;
  const Screen({required this.client, required this.child, super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      body: Column(
        children: [
          Expanded(child: child),
          Statusbar(
            client: client,
            defaultColor: colorScheme.secondaryContainer,
            accentColor: colorScheme.errorContainer,
          ),
        ],
      ),
    );
  }
}
