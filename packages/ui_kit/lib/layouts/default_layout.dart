import 'package:flutter/widgets.dart';
import 'package:ui_kit/widgets.dart';

class DefaultLayout extends StatelessWidget {
  final Widget body;

  const DefaultLayout({required this.body, super.key});

  @override
  Widget build(BuildContext context) => Scaffold(body: body);
}
