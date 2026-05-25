import 'package:flutter/material.dart';
import 'package:vision/scope.dart';
import 'package:vision/session/session_state.dart';
import 'package:vision/widgets/statusbar_connected.dart';
import 'package:vision/widgets/statusbar_connecting.dart';
import 'package:vision/widgets/statusbar_container.dart';

class Statusbar extends StatelessWidget {
  const Statusbar({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final session = Scope.of(context).session;
    return ListenableBuilder(
      listenable: session,
      builder: (context, _) => session.state == SessionState.connected
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
