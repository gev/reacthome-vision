import 'package:flutter/widgets.dart';
import 'package:ui_kit/layouts/center_layout.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const CenterLayout(
      body: Center(child: Text('Experiment is experiment!')),
    );
  }
}
