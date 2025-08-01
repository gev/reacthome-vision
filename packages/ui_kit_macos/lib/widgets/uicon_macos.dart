import 'package:flutter/widgets.dart';
import 'package:macos_ui/macos_ui.dart';

class UIconMacOS extends StatelessWidget {
  final IconData icon;
  final Color? color;
  final double? size;

  const UIconMacOS(this.icon, {this.color, this.size, super.key});

  @override
  Widget build(BuildContext context) {
    return MacosIcon(icon, color: color, size: size);
  }
}
