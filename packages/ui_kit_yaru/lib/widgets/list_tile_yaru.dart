import 'package:flutter/material.dart';
import 'package:yaru/yaru.dart';

class ListTileYaru extends StatelessWidget {
  final Widget title;
  final Widget? subtitle;
  final Widget? leading;
  final Widget? trailing;
  final void Function()? onTap;

  const ListTileYaru({
    required this.title,
    this.subtitle,
    this.leading,
    this.trailing,
    this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: YaruTile(
        title: title,
        subtitle: subtitle,
        leading: leading,
        trailing: trailing,
      ),
    );
  }
}
