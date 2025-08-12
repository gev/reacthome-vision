import 'package:flutter/widgets.dart';
import 'package:multi_split_view/multi_split_view.dart';
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
    return MultiSplitViewTheme(
      data: MultiSplitViewThemeData(dividerThickness: 4),
      child: MultiSplitView(
        initialAreas: [
          Area(
            min: 160,
            size: 240,
            max: 320,
            builder: (context, area) => startSidebar,
          ),
          Area(
            size: 250,
            builder: (context, area) {
              final theme = UI.themeOf(context);
              return Container(
                color: theme.backgroundColor,
                child: Column(
                  children: [
                    SizedBox(height: 52, child: title),
                    Expanded(
                      child: MultiSplitView(
                        initialAreas: [
                          Area(builder: (context, area) => body),
                          Area(
                            min: 160,
                            size: 240,
                            max: 320,
                            builder: (context, area) => endSidebar,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
