import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:navigation/navigator_extension.dart';
import 'package:studio/ui/navigation.dart';
import 'package:studio/ui/widgets/logo.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Timer(const Duration(seconds: 1), () {
      final navigator = Navigator.of(context);
      navigator.clearNamed(NavigationRouteNames.welcome);
    });
    return Center(child: logo(width: 120));
  }
}
