import 'dart:async';

import 'package:flow/core/home/home_api.dart';
import 'package:flow/core/preferences/preferences_api.dart';
import 'package:flow/ui/navigation.dart';
import 'package:flow/ui/widgets/logo.dart';
import 'package:flutter/widgets.dart';
import 'package:navigation/navigator_extension.dart';

class SplashScreen extends StatelessWidget {
  final PreferencesApi preferencesApi;
  final HomeApi homeApi;

  const SplashScreen({
    required this.preferencesApi,
    required this.homeApi,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    Timer(const Duration(seconds: 5), () {
      final navigator = Navigator.of(context);
      if (preferencesApi.isHomeSelected) {
        navigator.clearNamed(
          NavigationRouteNames.home,
          arguments: (id: preferencesApi.home),
        );
      } else {
        navigator.clearNamed(
          homeApi.homes.isEmpty
              ? NavigationRouteNames.welcome
              : NavigationRouteNames.myHomes,
        );
      }
    });
    return Center(child: logo(width: 120));
  }
}
