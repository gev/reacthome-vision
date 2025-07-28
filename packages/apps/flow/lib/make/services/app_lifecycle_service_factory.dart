import 'package:flow/make/config.dart';
import 'package:flow/make/core/app_lifecycle_factory.dart';
import 'package:flow/make/core/connectivity_factory.dart';
import 'package:flow/make/core/discovery_factory.dart';
import 'package:flow/make/core/home_connection_factory.dart';
import 'package:flow/make/core/home_factory.dart';
import 'package:flow/services/app_life_cycle/app_life_cycle_discovery_service.dart';
import 'package:flow/services/app_life_cycle/app_lifecycle_home_connection_service.dart';

class AppLifecycleServiceFactory {
  AppLifecycleServiceFactory._();

  static DiscoveryLifecycleService makeLifecycleDiscoveryService() =>
      DiscoveryLifecycleService(
        eventSource: AppLifecycleFactory.appLifecycleEventBus.stream,
        discoveryApi: DiscoveryFactory.makeDiscoveryApi(),
        connectivityApi: ConnectivityFactory.makeConnectivityApi(),
        restartTimeout: Config.discovery.restartTimeout,
      );

  static Future<AppLifecycleHomeConnectionService>
  makeLifecycleHomeConnectionService() async =>
      AppLifecycleHomeConnectionService(
        eventSource: AppLifecycleFactory.appLifecycleEventBus.stream,
        homeApi: await HomeFactory.makeHomeApi(),
        connectionApi: await HomeConnectionFactory.makeHomeConnectionApi(),
        connectivityApi: ConnectivityFactory.makeConnectivityApi(),
        reconnectTimeout: Config.connection.reconnectTimeout,
      );

  static Future<void> make() async {
    makeLifecycleDiscoveryService();
    await makeLifecycleHomeConnectionService();
  }
}
