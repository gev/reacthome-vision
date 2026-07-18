import 'package:flutter/widgets.dart';
import 'package:vision/session/session_state.dart';

typedef SessionMonitor = ValueNotifier<SessionState>;

SessionMonitor sessionMonitor() => SessionMonitor(SessionState.disconnected);
