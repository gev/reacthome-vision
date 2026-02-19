import 'package:flutter/material.dart';
import 'package:vision/logo.dart';

class Splash extends StatelessWidget {
  final String title;
  const Splash(this.title, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Logo(width: 64),
            SizedBox(height: 16),
            Text(title),
            SizedBox(height: 16),
            CircularProgressIndicator.adaptive(),
          ],
        ),
      ),
    );
  }
}
