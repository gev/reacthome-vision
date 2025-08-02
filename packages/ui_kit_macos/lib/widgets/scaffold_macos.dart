import 'package:flutter/widgets.dart';
import 'package:macos_ui/macos_ui.dart';

class ScaffoldMacOS extends StatelessWidget {
  final PreferredSizeWidget? appBar;
  final Widget body;

  const ScaffoldMacOS({this.appBar, required this.body, super.key});

  @override
  Widget build(BuildContext context) {
    return MacosWindow(
      child: MacosScaffold(
        children: [
          ContentArea(
            builder: (BuildContext context, ScrollController scrollController) {
              return body;
            },
          ),
        ],
      ),
    );
  }
}
