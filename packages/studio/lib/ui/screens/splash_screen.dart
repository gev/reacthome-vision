import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:studio/ui/widgets/logo.dart';
import 'package:studio/util/navigator_extension.dart';
import 'package:ui_kit/layouts/center_layout.dart';
import 'package:ui_kit/navigation.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Timer(const Duration(seconds: 1), () {
      final navigator = Navigator.of(context);
      navigator.clearNamed(NavigationRouteNames.welcome);
    });
    return CenterLayout(body: logo(width: 120));
  }
}
