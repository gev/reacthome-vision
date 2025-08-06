import 'package:flutter/widgets.dart';
import 'package:macos_ui/macos_ui.dart';

class ScaffoldMacos extends StatelessWidget {
  final ToolBar? appBar;
  final Widget body;

  const ScaffoldMacos({Widget? appBar, required this.body, super.key})
    : appBar = appBar as ToolBar?;

  @override
  Widget build(BuildContext context) {
    return MacosScaffold(
      toolBar: appBar,
      children: [
        ContentArea(
          builder: (BuildContext context, ScrollController scrollController) {
            return body;
          },
        ),
      ],
    );
  }
}
