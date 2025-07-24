import 'package:flutter/widgets.dart';
import 'package:ui_kit/widgets.dart';

class CenterLayout extends StatelessWidget {
  final Widget body;

  const CenterLayout({required this.body, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: body));
  }
}
