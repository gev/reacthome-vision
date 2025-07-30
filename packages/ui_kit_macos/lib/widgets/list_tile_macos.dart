import 'package:flutter/cupertino.dart';

class ListTileMacOS extends StatelessWidget {
  final Widget title;
  final Widget? subtitle;
  final Widget? leading;
  final Widget? trailing;
  final void Function()? onTap;

  const ListTileMacOS({
    required this.title,
    this.subtitle,
    this.leading,
    this.trailing,
    this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CupertinoListTile.notched(
      title: title,
      subtitle: subtitle,
      leading: leading,
      trailing: trailing,
      onTap: onTap,
    );
  }
}
