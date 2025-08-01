import 'package:flutter/cupertino.dart';

class UIconCupertino extends StatelessWidget {
  final IconData icon;
  final Color? color;
  final double? size;

  const UIconCupertino({required this.icon, this.color, this.size, super.key});

  @override
  Widget build(BuildContext context) {
    return Icon(icon, color: color, size: size);
  }
}
