import 'dart:ui';

import 'package:flutter/widgets.dart';

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
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 100.0, sigmaY: 100.0),
      child: Column(
        children: [
          SizedBox(height: 52, child: title),
          Expanded(
            child: Row(
              children: [
                SizedBox(width: 200, child: startSidebar),
                Expanded(child: body),
                SizedBox(width: 200, child: endSidebar),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
