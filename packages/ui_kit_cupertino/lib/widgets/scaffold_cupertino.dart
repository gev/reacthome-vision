import 'package:flutter/cupertino.dart';

class ScaffoldCupertino extends StatelessWidget {
  final ObstructingPreferredSizeWidget? appBar;
  final Widget body;

  const ScaffoldCupertino({Widget? appBar, required this.body, super.key})
    : appBar = appBar as ObstructingPreferredSizeWidget;

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(navigationBar: appBar, child: body);
  }
}
