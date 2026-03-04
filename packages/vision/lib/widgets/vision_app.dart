import 'dart:async';

import 'package:flutter/material.dart';
import 'package:vision/navigation/app_navigator.dart';
import 'package:vision/navigation/app_route.dart';
import 'package:vision/screens/home_screen.dart';
import 'package:vision/screens/splash_screen.dart';
import 'package:vision/widgets/theme.dart';

class VisionApp extends StatelessWidget {
  final String title;

  VisionApp({required this.title, super.key}) {
    Timer(Duration(seconds: 3), () {
      AppNavigator.pushReplacement(makeRoute(HomeScreen()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: title,
      navigatorKey: AppNavigator.navigatorKey,
      themeMode: ThemeMode.system,
      theme: makeTheme(Colors.blue, Brightness.light),
      darkTheme: makeTheme(Colors.blue, Brightness.dark),
      home: SplashScreen(title: title),
    );
  }
}
