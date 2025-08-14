import 'package:flutter/widgets.dart';
import 'package:ui_kit/layouts/desktop/sidebar_controller.dart';
import 'package:ui_kit/layouts/desktop/splitter.dart';

abstract class Sidebar extends StatelessWidget {
  final double? splitterSize;
  final SidebarController controller;
  final Widget? child;

  const Sidebar({
    this.splitterSize,
    required this.controller,
    this.child,
    super.key,
  });

  Widget get body => SizedBox(width: controller.size, child: child);

  Splitter get splitter;

  List<Widget> get children;

  @override
  Widget build(BuildContext context) {
    return Row(children: children);
  }
}

class StartSideBar extends Sidebar {
  const StartSideBar({
    super.splitterSize,
    required super.controller,
    super.child,
    super.key,
  });

  @override
  Splitter get splitter =>
      StartSplitter(size: splitterSize, controller: controller);

  @override
  List<Widget> get children => [body, splitter];
}

class EndSideBar extends Sidebar {
  const EndSideBar({
    super.splitterSize,
    required super.controller,
    super.child,
    super.key,
  });

  @override
  Splitter get splitter =>
      EndSplitter(size: splitterSize, controller: controller);

  @override
  List<Widget> get children => [splitter, body];
}
