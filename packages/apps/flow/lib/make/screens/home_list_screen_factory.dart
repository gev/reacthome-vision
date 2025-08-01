import 'package:flow/make/core/home_factory.dart';
import 'package:flow/make/core/preferences_factory.dart';
import 'package:flow/ui/screens/home_list_screen.dart';
import 'package:flow/ui/view_models/home_list_view_model.dart';
import 'package:flow/ui/view_models/home_view_model.dart';
import 'package:flutter/widgets.dart';

class AddHomeListFactory {
  AddHomeListFactory._();

  static Future<HomesViewModel> makeHomeViewModel() async => HomesViewModel(
    eventSource: HomeFactory.homeEventBus.stream,
    preferencesApi: await PreferencesFactory.makePreferencesApi(),
    homeApi: await HomeFactory.makeHomeApi(),
  );

  static Future<HomeListViewModel> makeHomeListViewModel() async =>
      HomeListViewModel(
        eventSource: HomeFactory.homeEventBus.stream,
        homeApi: await HomeFactory.makeHomeApi(),
      );

  static Future<WidgetBuilder> make() async {
    final homeViewModel = await makeHomeViewModel();
    final homeListViewModel = await makeHomeListViewModel();
    return (_) => HomeListScreen(
      homeViewModel: homeViewModel,
      homeListViewModel: homeListViewModel,
    );
  }
}
