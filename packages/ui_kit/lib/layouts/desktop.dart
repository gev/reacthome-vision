import 'package:flutter/widgets.dart';
import 'package:ui_kit/widgets.dart';

class Desktop extends StatelessWidget {
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
  Widget build(BuildContext context) {
    final theme = UI.themeOf(context);
    return Row(
      children: [
        SizedBox(width: 320, child: startSidebar),
        Expanded(
          child: Container(
            color: theme.backgroundColor,
            child: Column(
              children: [
                SizedBox(height: 52, child: title),
                Expanded(
                  child: Row(
                    children: [
                      Expanded(child: ClipRect(child: body)),
                      SizedBox(width: 240, child: endSidebar),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
