import 'package:flutter/widgets.dart';
import 'package:ui_kit/widgets.dart';

class FullWidthLayout extends StatelessWidget {
  final String title;
  final Widget body;

  const FullWidthLayout({required this.title, required this.body, super.key});

  @override
  Widget build(BuildContext context) {
    return UI.Scaffold(
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          UI.AppBarSliver(title: title),
          SliverFillRemaining(
            hasScrollBody: false,
            fillOverscroll: true,
            child: body,
          ),
        ],
      ),
    );
  }
}
