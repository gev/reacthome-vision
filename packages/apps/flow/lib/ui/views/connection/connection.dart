import 'package:flutter/widgets.dart';
import 'package:ui_kit/widgets.dart';
import 'package:utils/extensions.dart';

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
  Widget build(BuildContext context) => ListTile(
    title: Text(title),
    subtitle: subtitle?.let(Text.new),
    trailing: Switcher(value: isConnected, onChanged: onToggle),
  );
}
