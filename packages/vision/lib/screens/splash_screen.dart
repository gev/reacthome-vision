import 'package:flutter/material.dart';
import 'package:vision/widgets/logo.dart';
import 'package:vision/widgets/screen.dart';

class SplashScreen extends StatelessWidget {
  final String title;

  const SplashScreen({required this.title, super.key});

  @override
  Widget build(BuildContext context) {
    return Screen(
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
