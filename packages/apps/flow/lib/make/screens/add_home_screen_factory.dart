import 'package:flow/make/core/home_factory.dart';
import 'package:flow/make/core/preferences_factory.dart';
import 'package:flow/ui/screens/add_home_screen.dart';
import 'package:flow/ui/view_models/home_view_model.dart';
import 'package:flutter/widgets.dart';

class AddHomeScreenFactory {
  AddHomeScreenFactory._();

  static Future<HomesViewModel> makeHomeViewModel() async => HomesViewModel(
    eventSource: HomeFactory.homeEventBus.stream,
    preferencesApi: await PreferencesFactory.makePreferencesApi(),
    homeApi: await HomeFactory.makeHomeApi(),
  );

  static Future<WidgetBuilder> make() async {
    final homeViewModel = await makeHomeViewModel();
    return (_) => AddHomeScreen(viewModel: homeViewModel);
  }
}
