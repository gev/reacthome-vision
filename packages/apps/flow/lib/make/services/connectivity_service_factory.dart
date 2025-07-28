import 'package:flow/make/core/connectivity_factory.dart';
import 'package:flow/make/core/discovery_factory.dart';
import 'package:flow/make/core/home_connection_factory.dart';
import 'package:flow/make/core/home_factory.dart';
import 'package:flow/services/connectivity/connectivity_change_service.dart';
import 'package:flow/services/connectivity/connectivity_discovery_service.dart';
import 'package:flow/services/connectivity/connectivity_home_connection_service.dart';

class ConnectivityServiceFactory {
  ConnectivityServiceFactory._();

  static ConnectivityChangeService makeChangeConnectivityService() =>
      ConnectivityChangeService(
        connectivity: ConnectivityFactory.makeConnectivityApi(),
      );

  static Future<ConnectivityHomeConnectionService>
  makeConnectivityHomeConnectionService() async =>
      ConnectivityHomeConnectionService(
        eventSource: ConnectivityFactory.connectivityEventBus.stream,
        homeApi: await HomeFactory.makeHomeApi(),
        connectionApi: await HomeConnectionFactory.makeHomeConnectionApi(),
      );

  static ConnectivityDiscoveryService makeConnectivityDiscoveryService() =>
      ConnectivityDiscoveryService(
        eventSource: ConnectivityFactory.connectivityEventBus.stream,
        discoveryApi: DiscoveryFactory.makeDiscoveryApi(),
      );

  static Future<void> make() async {
    makeConnectivityDiscoveryService();
    await makeConnectivityHomeConnectionService();
    makeChangeConnectivityService();
  }
}
