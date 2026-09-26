import 'package:flutter/widgets.dart';
import 'package:vision/websocket/connection_state.dart';

typedef ConnectionMonitor = ValueNotifier<ConnectionStatus>;

ConnectionMonitor connectionMonitor() =>
    ConnectionMonitor(ConnectionStatus.disconnected);
