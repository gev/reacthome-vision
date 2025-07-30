import 'package:flutter/cupertino.dart';

class ScaffoldMacOS extends StatelessWidget {
  final PreferredSizeWidget? appBar;
  final Widget body;

  const ScaffoldMacOS({this.appBar, required this.body, super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: appBar as ObstructingPreferredSizeWidget?,
      child: body,
    );
  }
}
