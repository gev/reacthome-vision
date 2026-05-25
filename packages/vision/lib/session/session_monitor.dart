import 'package:flutter/widgets.dart';
import 'package:vision/session/session_state.dart';

class SessionMonitor extends ChangeNotifier {
  var _state = SessionState.disconnected;

  SessionState get state => _state;

  set state(SessionState newState) {
    if (newState != _state) {
      _state = newState;
      notifyListeners();
    }
  }
}
