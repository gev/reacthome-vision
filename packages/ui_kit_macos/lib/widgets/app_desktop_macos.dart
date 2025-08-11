import 'package:flutter/widgets.dart';
import 'package:macos_ui/macos_ui.dart';
import 'package:ui_kit/layouts/desktop.dart';

class AppDesktopMacos extends StatelessWidget {
  final Widget? title;
  final Widget startSidebar;
  final Widget endSidebar;
  final Widget body;

  const AppDesktopMacos({
    required this.startSidebar,
    required this.endSidebar,
    required this.body,
    this.title,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MacosWindow(
      backgroundColor: MacosColors.transparent,
      child: Desktop(
        title: title,
        startSidebar: startSidebar,
        endSidebar: endSidebar,
        body: body,
      ),
    );
  }
}
