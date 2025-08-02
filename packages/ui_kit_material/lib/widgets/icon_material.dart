import 'package:flutter/material.dart';

class IconMaterial extends StatelessWidget {
  final IconData icon;
  final Color? color;
  final double? size;

  const IconMaterial(this.icon, {this.color, this.size, super.key});

  @override
  Widget build(BuildContext context) {
    return Icon(icon, color: color, size: size);
  }
}
