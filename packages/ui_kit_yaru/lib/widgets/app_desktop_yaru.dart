import 'package:flutter/widgets.dart';
import 'package:ui_kit/layouts/desktop.dart';
import 'package:yaru/yaru.dart';

class AppDesktopYaru extends StatelessWidget {
  final Widget? title;
  final Widget startSidebar;
  final Widget endSidebar;
  final Widget body;

  const AppDesktopYaru({
    this.title,
    required this.startSidebar,
    required this.endSidebar,
    required this.body,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Desktop(
      title: YaruWindowTitleBar(title: title),
      startSidebar: startSidebar,
      endSidebar: endSidebar,
      body: body,
    );
  }
}
