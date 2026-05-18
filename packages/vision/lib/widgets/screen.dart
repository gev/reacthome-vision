import 'package:flutter/material.dart';
import 'package:vision/widgets/statusbar.dart';

class Screen extends StatelessWidget {
  final Widget? body;
  late final PreferredSizeWidget _appBar;

  Screen({this.body, PreferredSizeWidget? appBar, super.key}) {
    _appBar = appBar ?? AppBar();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar,
      body: Column(
        children: [
          Expanded(child: body ?? SizedBox()),
          Statusbar(),
        ],
      ),
    );
  }
}
