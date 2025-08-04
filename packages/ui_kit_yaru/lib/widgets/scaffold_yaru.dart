import 'package:flutter/material.dart';
import 'package:yaru/yaru.dart';

class ScaffoldYaru extends StatelessWidget {
  final PreferredSizeWidget? appBar;
  final Widget body;

  const ScaffoldYaru({this.appBar, required this.body, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: const YaruWindowTitleBar(), body: body);
  }
}
