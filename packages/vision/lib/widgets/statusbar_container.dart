import 'package:flutter/material.dart';

class StatusBarContainer extends StatelessWidget {
  final double height;
  final Color background;
  final Widget child;
  const StatusBarContainer({
    required this.height,
    required this.background,
    required this.child,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      width: double.infinity,
      height: height,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.bottomLeft,
          end: Alignment.topLeft,
          colors: [background, Colors.transparent],
        ),
      ),
      // color: colorScheme.errorContainer,
      padding: EdgeInsetsGeometry.symmetric(horizontal: 16, vertical: 8),
      child: child,
    );
  }
}
