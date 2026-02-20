import 'package:flutter/material.dart';
import 'package:vision/websocket/websocket_client.dart';
import 'package:vision/websocket/websocket_state.dart';
import 'package:vision/widgets/statusbar_connected.dart';
import 'package:vision/widgets/statusbar_connecting.dart';
import 'package:vision/widgets/statusbar_container.dart';

class Statusbar extends StatefulWidget {
  final WebSocketClient client;
  final Color defaultColor;
  final Color accentColor;

  const Statusbar({
    required this.client,
    required this.defaultColor,
    required this.accentColor,
    super.key,
  });

  @override
  State<StatefulWidget> createState() => _StatusbarState();
}

class _StatusbarState extends State<Statusbar> {
  double height = 0;
  Color color = Colors.transparent;
  Widget content = SizedBox();

  void onStatusChange() {
    switch (widget.client.state) {
      case WebSocketConnectionState.connected:
        setConnected();
      case _:
        setConnecting();
    }
  }

  void setConnected() {
    setState(() {
      height = 0;
      color = widget.defaultColor;
      content = StatusbarConnected();
    });
  }

  void setConnecting() {
    setState(() {
      height = 40;
      color = widget.accentColor;
      content = StatusbarConnecting();
    });
  }

  @override
  void initState() {
    super.initState();
    widget.client.addListener(onStatusChange);
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
  void dispose() {
    widget.client.removeListener(onStatusChange);
    super.dispose();
  }
}
