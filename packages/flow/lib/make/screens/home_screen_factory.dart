import 'package:flow/make/core/connection_factory.dart';
import 'package:flow/make/core/home_connection_factory.dart';
import 'package:flow/make/core/home_factory.dart';
import 'package:flow/make/core/preferences_factory.dart';
import 'package:flow/ui/screens/home_screen.dart';
import 'package:flow/ui/view_models/connection_view_model.dart';
import 'package:flow/ui/view_models/home_view_model.dart';
import 'package:flutter/widgets.dart';

class HomeScreenFactory {
  HomeScreenFactory._();

  static Future<HomesViewModel> makeHomeViewModel() async => HomesViewModel(
    eventSource: HomeFactory.homeEventBus.stream,
    preferencesApi: await PreferencesFactory.makePreferencesApi(),
    homeApi: await HomeFactory.makeHomeApi(),
  );

  static Future<ConnectionsViewModel> makeConnectionViewModel() async =>
      ConnectionsViewModel(
        eventSource: ConnectionFactory.connectionEventBus.stream,
        homeConnectionApi: await HomeConnectionFactory.makeHomeConnectionApi(),
        localConnectionApi: ConnectionFactory.makeLocalConnectionApi(),
        cloudConnectionApi: ConnectionFactory.makeCloudConnectionApi(),
        homeApi: await HomeFactory.makeHomeApi(),
      );

  static Future<WidgetBuilder> make() async {
    final homeViewModel = await makeHomeViewModel();
    final connectionViewModel = await makeConnectionViewModel();
    return (_) => HomeScreen(
      homeViewModel: homeViewModel,
      connectionViewModel: connectionViewModel,
    );
  }
}
