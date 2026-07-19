import 'package:flutter/widgets.dart';
import 'package:vision/mode/live/session/session_state.dart';

typedef SessionMonitor = ValueNotifier<SessionState>;

SessionMonitor sessionMonitor() => SessionMonitor(SessionState.disconnected);
