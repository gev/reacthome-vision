import 'package:flutter/widgets.dart';
import 'package:multi_split_view/multi_split_view.dart';

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
    return Column(
      children: [
        SizedBox(height: 52, child: title),
        Expanded(
          child: MultiSplitView(
            initialAreas: [
              Area(size: 250, builder: (context, area) => startSidebar),
              Area(builder: (context, area) => body),
              Area(size: 250, builder: (context, area) => endSidebar),
            ],
          ),
        ),
      ],
    );
  }
}
