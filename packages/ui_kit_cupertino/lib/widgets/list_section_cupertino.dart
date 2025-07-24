import 'package:flutter/cupertino.dart';

class ListSectionCupertino extends StatelessWidget {
  final String? title;
  final List<Widget> children;
  final bool hasLeading;

  const ListSectionCupertino({
    this.title,
    required this.children,
    this.hasLeading = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    if (title != null) {
      return CupertinoListSection.insetGrouped(
        hasLeading: hasLeading,
        header: Text(title!),
        children: children,
      );
    } else {
      return CupertinoListSection(hasLeading: hasLeading, children: children);
    }
  }
}
