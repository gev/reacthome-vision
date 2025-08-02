import 'package:flutter/material.dart';
import 'package:ui_kit/widgets.dart';

class AppBarSliverMaterial extends StatelessWidget {
  final String title;
  final Widget? trailing;

  const AppBarSliverMaterial({required this.title, this.trailing, super.key});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar.medium(
      pinned: true,
      stretch: true,
      title: Text(title),
      flexibleSpace: FlexibleSpaceBar(
        collapseMode: CollapseMode.pin,
        background: Container(
          alignment: AlignmentDirectional.bottomStart,
          padding: UI.DefaultPadding.edgeInsets,
          child: Text(title, style: Theme.of(context).textTheme.headlineLarge),
        ),
      ),
      actions: trailing != null ? [trailing!] : [],
    );
  }
}
