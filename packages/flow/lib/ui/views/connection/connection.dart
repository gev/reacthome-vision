import 'package:flow/ui_kit/kit.dart';
import 'package:flow/util/extensions.dart';
import 'package:flutter/widgets.dart';

class Connection extends StatelessWidget {
  final bool isConnected;
  final String title;
  final String? subtitle;
  final void Function(bool) onToggle;

  const Connection({
    required this.isConnected,
    required this.title,
    this.subtitle,
    required this.onToggle,
    super.key,
  });

  @override
  Widget build(BuildContext context) => list.tile(
    title: Text(title),
    subtitle: subtitle?.let(Text.new),
    trailing: switcher(value: isConnected, onChanged: onToggle),
  );
}
