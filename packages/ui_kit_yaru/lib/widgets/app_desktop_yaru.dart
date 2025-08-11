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
      title: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          spacing: 8,
          children: [
            ?title,
            YaruWindowControl(
              type: YaruWindowControlType.minimize,
              onTap: () {
                YaruWindow.minimize(context);
              },
            ),
            FutureBuilder(
              future: YaruWindow.state(context),
              builder: (context, snapshot) {
                final isMaximized = snapshot.data?.isMaximized ?? false;
                return isMaximized
                    ? YaruWindowControl(
                        type: YaruWindowControlType.restore,
                        onTap: () {
                          YaruWindow.restore(context);
                        },
                      )
                    : YaruWindowControl(
                        type: YaruWindowControlType.maximize,
                        onTap: () {
                          YaruWindow.maximize(context);
                        },
                      );
              },
            ),
            YaruWindowControl(
              type: YaruWindowControlType.close,
              onTap: () {
                YaruWindow.close(context);
              },
            ),
          ],
        ),
      ),
      startSidebar: startSidebar,
      endSidebar: endSidebar,
      body: body,
    );
  }
}
