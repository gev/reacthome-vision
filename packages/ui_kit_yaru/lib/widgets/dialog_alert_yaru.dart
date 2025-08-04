import 'package:flutter/material.dart';
import 'package:yaru/yaru.dart';

class AlertDialogYaru extends StatelessWidget {
  final Widget? title;
  final Widget? content;
  final List<Widget> actions;

  const AlertDialogYaru({
    this.title,
    this.content,
    required this.actions,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      actions: actions,
      titlePadding: EdgeInsets.zero,
      title: YaruDialogTitleBar(title: title, isClosable: true),
      content: SizedBox(
        height: 100,
        child: YaruBanner.tile(
          // surfaceTintColor: Colors.pink,
          title: title!,
          subtitle: content,
          // icon: const Text('🪟', style: TextStyle(fontSize: 30)),
        ),
      ),
    );
  }
}
