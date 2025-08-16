import 'package:flutter/widgets.dart';
import 'package:lab/ui/views/iconic_palette.dart';
import 'package:ui_kit/widgets.dart';

final iconics = [];

class IconicScreen extends StatelessWidget {
  const IconicScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return UI.Scaffold(
      appBar: UI.AppBar(title: 'Iconic Experiment'),
      body: const IconicPalette(),
    );
  }
}
