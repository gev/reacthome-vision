import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:ui_kit/kit.dart';
import 'package:ui_kit/navigation.dart';

class App extends StatelessWidget {
  final Color seedColor;
  final Navigation navigation;
  final String title;

  const App({
    required this.navigation,
    required this.seedColor,
    this.title = 'Reacthome Studio',
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    SystemChrome.restoreSystemUIOverlays();
    return Kit.app.root(
      context,
      navigation: navigation,
      title: title,
      seedColor: seedColor,
    );
  }
}
