import 'dart:async';

import 'package:flow/core/app_lifecycle/app_lifecycle_api.dart';
import 'package:flow/ui/navigation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:ui_kit/widgets.dart';

class App extends StatelessWidget with WidgetsBindingObserver {
  final AppLifecycleApi appLifeCycle;
  final FlowNavigation navigation;
  final Iterable<LocalizationsDelegate<dynamic>> localizationsDelegates;
  final Iterable<Locale> supportedLocales;
  final Color seedColor;
  final String title;

  App({
    required this.appLifeCycle,
    required this.navigation,
    required this.localizationsDelegates,
    required this.supportedLocales,
    required this.seedColor,
    this.title = 'Reacthome X',
    super.key,
  }) {
    WidgetsBinding.instance.addObserver(this);
    appLifeCycle.makeActive();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.restoreSystemUIOverlays();
    return AppRoot(
      navigation: navigation,
      localizationsDelegates: localizationsDelegates,
      supportedLocales: supportedLocales,
      title: title,
      seedColor: seedColor,
    );
  }

  final _timer = _Wrapper<Timer>();

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        _timer.value?.cancel();
        appLifeCycle.makeActive();
      case AppLifecycleState.paused:
        _timer.value = Timer(const Duration(seconds: 10), () {
          appLifeCycle.makeInactive();
        });
      default:
    }
  }

  void dispose() {
    _timer.value?.cancel();
    WidgetsBinding.instance.removeObserver(this);
    appLifeCycle.makeInactive();
  }
}

class _Wrapper<T> {
  T? value;
}
