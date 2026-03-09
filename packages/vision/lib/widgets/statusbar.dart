import 'package:flutter/material.dart';
import 'package:vision/websocket/websocket_client.dart';
import 'package:vision/websocket/websocket_state.dart';
import 'package:vision/widgets/statusbar_connected.dart';
import 'package:vision/widgets/statusbar_connecting.dart';
import 'package:vision/widgets/statusbar_container.dart';
import 'package:vision/widgets/vision_scope.dart';

class Statusbar extends StatefulWidget {
  const Statusbar({super.key});

  @override
  State<StatefulWidget> createState() => _StatusbarState();
}

class _StatusbarState extends State<Statusbar> {
  WebSocketClient? client;
  double height = 0;
  Color color = Colors.transparent;
  Widget content = SizedBox();

  void onStatusChange() {
    switch (client?.state) {
      case WebSocketConnectionState.connected:
        setConnected();
      case _:
        setConnecting();
    }
  }

  void setConnected() {
    final colorScheme = Theme.of(context).colorScheme;
    setState(() {
      height = 0;
      color = colorScheme.secondaryContainer;
      content = StatusbarConnected();
    });
  }

  void setConnecting() {
    final colorScheme = Theme.of(context).colorScheme;
    setState(() {
      height = 40;
      color = colorScheme.errorContainer;
      content = StatusbarConnecting();
    });
  }

  @override
  Widget build(BuildContext context) {
    return StatusBarContainer(
      height: height,
      background: color,
      child: content,
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final newClient = VisionScope.of(context).client;
    if (newClient == client) return;
    client?.removeListener(onStatusChange);
    newClient.addListener(onStatusChange);
    client = newClient;
    onStatusChange();
  }

  @override
  void dispose() {
    client?.removeListener(onStatusChange);
    super.dispose();
  }
}
