import 'package:flow/ui_kit/kit.dart';
import 'package:flutter/widgets.dart';

class DefaultLayout extends StatelessWidget {
  final Widget body;

  const DefaultLayout({required this.body, super.key});

  @override
  Widget build(BuildContext context) => scaffold(body: body);
}
