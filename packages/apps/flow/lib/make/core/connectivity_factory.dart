import 'package:common/bus/bus.dart';
import 'package:flow/core/connectivity/connectivity_api.dart';
import 'package:flow/core/connectivity/connectivity_entity.dart';
import 'package:flow/core/connectivity/connectivity_event.dart';
import 'package:flow/core/connectivity/connectivity_service.dart';

class ConnectivityFactory {
  ConnectivityFactory._();

  static final connectivity = ConnectivityEntity();

  static final connectivityEventBus = Bus<ConnectivityEvent>();

  static ConnectivityApi makeConnectivityApi() => ConnectivityService(
    eventSink: connectivityEventBus.sink,
    connectivity: connectivity,
  );
}
