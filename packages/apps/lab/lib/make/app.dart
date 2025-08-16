import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:navigation/navigation.dart';
import 'package:ui_kit/widgets.dart';

class App extends StatelessWidget {
  final Color seedColor;
  final Navigation navigation;
  final String title;

  const App({
    required this.navigation,
    required this.seedColor,
    this.title = 'Reacthome Lab',
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    SystemChrome.restoreSystemUIOverlays();
    return UI.AppRoot(
      navigation: navigation,
      title: title,
      seedColor: seedColor,
    );
  }
}
