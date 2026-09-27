import 'package:flutter/widgets.dart';
import 'package:vision/connection/connection_status.dart';

typedef ConnectionMonitor = ValueNotifier<ConnectionStatus>;

ConnectionMonitor makeConnectionMonitor() =>
    ConnectionMonitor(ConnectionStatus.disconnected);
