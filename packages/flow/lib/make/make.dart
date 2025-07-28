import 'package:flow/l10n/app_localizations.dart';
import 'package:flow/make/config.dart';
import 'package:flow/make/controllers/reacthome_controller_factory.dart';
import 'package:flow/make/core/app_lifecycle_factory.dart';
import 'package:flow/make/screens/add_home_screen_factory.dart';
import 'package:flow/make/screens/discovery_screen_factory.dart';
import 'package:flow/make/screens/home_list_screen_factory.dart';
import 'package:flow/make/screens/home_screen_factory.dart';
import 'package:flow/make/screens/splash_screen_factory.dart';
import 'package:flow/make/screens/welcome_screen_factory.dart';
import 'package:flow/make/services/app_lifecycle_service_factory.dart';
import 'package:flow/make/services/connection_service_factory.dart';
import 'package:flow/make/services/connectivity_service_factory.dart';
import 'package:flow/make/services/discovery_service_factory.dart';
import 'package:flow/make/services/my_home_service_factory.dart';
import 'package:flow/ui/navigation.dart';
import 'package:flow/ui/views/app.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

Future<Widget> make() async {
  WidgetsFlutterBinding.ensureInitialized();

  await ConnectionServiceFactory.make();
  await DiscoveryServiceFactory.make();
  await AppLifecycleServiceFactory.make();
  await ConnectivityServiceFactory.make();

  await ReacthomeControllerFactory.makeControllers();

  await HomeServiceFactory.make();

  return App(
    localizationsDelegates: const [
      AppLocalizations.delegate,
      GlobalMaterialLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate,
    ],
    supportedLocales: const [Locale('en'), Locale('ru')],
    appLifeCycle: AppLifecycleFactory.makeAppLifecycleApi(),
    navigation: FlowNavigation(
      home: await HomeScreenFactory.make(),
      splash: await SplashScreenFactory.make(),
      welcome: WelcomeScreenFactory.make,
      discovery: await DiscoveryScreenFactory.make(),
      addHome: await AddHomeScreenFactory.make(),
      myHomes: await AddHomeListFactory.make(),
    ),
    seedColor: Config.theme.seedColor,
  );
}
