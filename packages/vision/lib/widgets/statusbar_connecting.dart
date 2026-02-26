import 'package:flutter/material.dart';

class StatusbarConnecting extends StatelessWidget {
  const StatusbarConnecting({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: 16,
          height: 16,
          child: CircularProgressIndicator.adaptive(strokeWidth: 2),
        ),
        SizedBox(width: 8),
        Text("Connecting"),
      ],
    );
  }
}
