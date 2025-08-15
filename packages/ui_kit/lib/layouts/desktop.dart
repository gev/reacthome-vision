import 'package:flutter/widgets.dart';
import 'package:ui_kit/layouts/desktop/sidebar.dart';
import 'package:ui_kit/layouts/desktop/sidebar_controller.dart';
import 'package:ui_kit/widgets.dart';

class Desktop extends StatefulWidget {
  final Widget? title;
  final Widget startSidebar;
  final Widget endSidebar;
  final Widget body;

  const Desktop({
    this.title,
    required this.startSidebar,
    required this.endSidebar,
    required this.body,
    super.key,
  });

  @override
  State<Desktop> createState() => _DesktopState();
}

class _DesktopState extends State<Desktop> {
  late SidebarController startSidebarController;
  late SidebarController endSidebarController;

  @override
  void initState() {
    super.initState();
    startSidebarController = SidebarController(320, minSize: 160, maxSize: 480);
    endSidebarController = SidebarController(220, minSize: 120, maxSize: 320);
  }

  @override
  Widget build(BuildContext context) {
    final theme = UI.themeOf(context);
    return SizedBox(
      width: MediaQuery.of(context).size.width, // или фиксированная ширина
      child: Row(
        children: [
          ListenableBuilder(
            listenable: startSidebarController,
            builder: (context, child) =>
                StartSideBar(controller: startSidebarController, child: child),
            child: widget.startSidebar,
          ),
          Expanded(
            child: Container(
              color: theme.backgroundColor,
              child: Column(
                children: [
                  SizedBox(height: 52, child: widget.title),
                  Expanded(
                    child: Row(
                      children: [
                        Expanded(child: ClipRect(child: widget.body)),
                        ListenableBuilder(
                          listenable: endSidebarController,
                          builder: (context, child) => EndSideBar(
                            controller: endSidebarController,
                            child: child,
                          ),
                          child: widget.endSidebar,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    startSidebarController.dispose();
    endSidebarController.dispose();
    super.dispose();
  }
}
