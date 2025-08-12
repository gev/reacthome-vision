import 'package:flutter/material.dart';
import 'package:ui_kit/layouts/desktop.dart';
import 'package:window_manager/window_manager.dart';

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
      title: _WindowCaptionWrapper(title: title),
      startSidebar: startSidebar,
      endSidebar: endSidebar,
      body: body,
    );
  }
}

class _WindowCaptionWrapper extends StatelessWidget {
  final Widget? title;

  const _WindowCaptionWrapper({this.title, super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return WindowCaption(brightness: theme.brightness, title: title);
  }
}
