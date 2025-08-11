import 'package:flutter/widgets.dart';
import 'package:ui_kit/layouts/desktop.dart';

class AppDesktopFluent extends StatelessWidget {
  final Widget? title;
  final Widget startSidebar;
  final Widget endSidebar;
  final Widget body;

  const AppDesktopFluent({
    required this.startSidebar,
    required this.endSidebar,
    required this.body,
    this.title,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Desktop(
      title: title,
      startSidebar: startSidebar,
      endSidebar: endSidebar,
      body: body,
    );
  }
}
