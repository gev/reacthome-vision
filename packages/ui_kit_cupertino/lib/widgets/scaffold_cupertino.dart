import 'package:flutter/cupertino.dart';

class ScaffoldCupertino extends StatelessWidget {
  final ObstructingPreferredSizeWidget? appBar;
  final Widget body;

  const ScaffoldCupertino({this.appBar, required this.body, super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(navigationBar: appBar, child: body);
  }
}
