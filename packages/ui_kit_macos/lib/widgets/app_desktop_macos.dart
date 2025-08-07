import 'package:flutter/widgets.dart';
import 'package:macos_ui/macos_ui.dart';

class AppDesktopMacos extends StatelessWidget {
  final Widget? toolbar;
  final Widget? start;
  final Widget? end;
  final Widget? body;

  const AppDesktopMacos({
    this.toolbar,
    this.start,
    this.end,
    this.body,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MacosWindow(
      sidebar: Sidebar(
        minWidth: 200,
        maxWidth: 500,
        builder: (_, _) {
          return start ?? const Center(child: Text("Sidebar Start"));
        },
      ),
      endSidebar: Sidebar(
        minWidth: 200,
        maxWidth: 500,
        builder: (_, controller) {
          return SingleChildScrollView(controller: controller, child: end);
        },
      ),
      titleBar: TitleBar(height: 51, title: toolbar),
      child: body,
    );
  }
}
