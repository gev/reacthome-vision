import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:macos_ui/macos_ui.dart';
import 'package:studio/ui/navigation.dart';

class App extends StatelessWidget {
  final Navigation navigation;
  final Color seedColor;
  final String title;

  const App({
    required this.navigation,
    required this.seedColor,
    this.title = 'Studio',
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    SystemChrome.restoreSystemUIOverlays();
    return MacosApp(title: title, routes: navigation.routes);
    // app.root(
    //   context,
    //   navigation: navigation,
    //   title: title,
    //   seedColor: seedColor,
    // );
  }
}
