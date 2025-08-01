import 'package:flutter/material.dart';

class UIconMaterial extends StatelessWidget {
  final IconData icon;
  final Color? color;
  final double? size;

  const UIconMaterial(this.icon, {this.color, this.size, super.key});

  @override
  Widget build(BuildContext context) {
    return Icon(icon, color: color, size: size);
  }
}
