import 'package:flutter/widgets.dart';
import 'package:ui_kit/kit.dart';

class CenterLayout extends StatelessWidget {
  final Widget body;

  const CenterLayout({required this.body, super.key});

  @override
  Widget build(BuildContext context) {
    return scaffold(body: Center(child: body));
  }
}
