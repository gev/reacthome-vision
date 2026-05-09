import 'package:flutter/material.dart';
import 'package:vision/websocket/websocket_state.dart';
import 'package:vision/widgets/statusbar_connected.dart';
import 'package:vision/widgets/statusbar_connecting.dart';
import 'package:vision/widgets/statusbar_container.dart';
import 'package:vision/widgets/vision_scope.dart';

class Statusbar extends StatelessWidget {
  const Statusbar({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final client = VisionScope.of(context).client;
    return ListenableBuilder(
      listenable: client,
      builder: (context, _) =>
          client.state == WebSocketConnectionState.connected
          ? StatusBarContainer(
              height: 0,
              background: colorScheme.secondaryContainer,
              child: StatusbarConnected(),
            )
          : StatusBarContainer(
              height: 40,
              background: colorScheme.errorContainer,
              child: StatusbarConnecting(),
            ),
    );
  }
}
