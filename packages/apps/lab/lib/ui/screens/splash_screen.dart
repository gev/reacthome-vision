import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:lab/ui/navigation.dart';
import 'package:lab/ui/widgets/logo.dart';
import 'package:navigation/navigator_extension.dart';
import 'package:ui_kit/layouts/center_layout.dart';
import 'package:ui_kit/widgets.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = UI.themeOf(context);
    Timer(const Duration(seconds: 1), () {
      final navigator = Navigator.of(context);
      navigator.clearNamed(NavigationRouteNames.iconic);
    });
    return CenterLayout(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          logo(width: 120),
          const SizedBox(height: 20),
          Text('Experiment is Experiment!', style: theme.titleStyle),
        ],
      ),
    );
  }
}
