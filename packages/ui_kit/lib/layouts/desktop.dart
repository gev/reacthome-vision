import 'package:flutter/widgets.dart';
import 'package:multi_split_view/multi_split_view.dart';

class Desktop extends StatelessWidget {
  final Widget? title;
  final Widget? startSidebar;
  final Widget? endSidebar;
  final Widget body;

  const Desktop({
    this.title,
    this.startSidebar,
    this.endSidebar,
    required this.body,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 52, child: title),
        MultiSplitView(
          initialAreas: [
            Area(builder: (context, area) => startSidebar!),
            Area(builder: (context, area) => body),
            Area(builder: (context, area) => endSidebar!),
          ],
        ),
      ],
    );
  }
}
