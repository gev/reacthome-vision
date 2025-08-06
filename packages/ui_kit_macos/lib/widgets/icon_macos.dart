import 'package:flutter/widgets.dart';
import 'package:macos_ui/macos_ui.dart';

class IconMacos extends StatelessWidget {
  final IconData icon;
  final Color? color;
  final double? size;

  const IconMacos(this.icon, {this.color, this.size, super.key});

  @override
  Widget build(BuildContext context) {
    return MacosIcon(icon, color: color, size: size);
  }
}
