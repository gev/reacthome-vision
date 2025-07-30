import 'package:flutter/cupertino.dart';

class AppBarSliverMacOS extends StatelessWidget {
  final String title;
  final Widget? trailing;

  const AppBarSliverMacOS({required this.title, this.trailing, super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoSliverNavigationBar(
      stretch: true,
      largeTitle: Text(title),
      trailing: trailing,
    );
  }
}
