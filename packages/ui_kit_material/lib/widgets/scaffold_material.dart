import 'package:flutter/material.dart';

class ScaffoldMaterial extends StatelessWidget {
  final PreferredSizeWidget? appBar;
  final Widget body;

  const ScaffoldMaterial({Widget? appBar, required this.body, super.key})
    : appBar = appBar as PreferredSizeWidget?;

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: appBar, body: body);
  }
}
