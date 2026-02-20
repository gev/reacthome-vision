import 'package:flutter/material.dart';

class StatusbarConnecting extends StatelessWidget {
  const StatusbarConnecting({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CircularProgressIndicator.adaptive(),
        SizedBox(width: 8),
        Text("Connecting"),
      ],
    );
  }
}
