import 'package:flutter/material.dart';

class ScaffoldMaterial extends StatelessWidget {
  final PreferredSizeWidget? appBar;
  final Widget body;

  const ScaffoldMaterial({this.appBar, required this.body, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: appBar, body: body);
  }
}
