import 'package:flow/core/connectivity/connectivity.dart';
import 'package:flow/core/connectivity/connectivity_event.dart';
import 'package:flow/core/connectivity/connectivity_state.dart';

class ConnectivityEntity implements Connectivity {
  ConnectivityState _state = const ConnectivityState();

  @override
  ConnectivityState get state => _state;

  @override
  ConnectivityEvent makeConnected(ConnectivityState state) {
    _state = state;
    return ConnectivityEvent(_state);
  }

  @override
  ConnectivityEvent makeDisconnected() {
    _state = const ConnectivityState();
    return ConnectivityEvent(_state);
  }
}
