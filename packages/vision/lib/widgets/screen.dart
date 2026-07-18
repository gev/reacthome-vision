import 'package:flutter/material.dart';

class Screen extends StatelessWidget {
  final Widget? body;
  late final PreferredSizeWidget _appBar;

  Screen({this.body, PreferredSizeWidget? appBar, super.key}) {
    _appBar = appBar ?? AppBar();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: _appBar, body: body ?? SizedBox());
  }
}
