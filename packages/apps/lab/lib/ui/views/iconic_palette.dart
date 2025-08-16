import 'package:flutter/widgets.dart';
import 'package:iconic/widgets/scheme_icon.dart';
import 'package:lab/ui/screens/iconic_screen.dart';

class IconicPalette extends StatelessWidget {
  const IconicPalette({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Wrap(
        children: [
          for (final it in iconics)
            Container(
              padding: const EdgeInsetsGeometry.all(20),
              child: SchemeIcon(makeIconic: it, size: 80),
            ),
        ],
      ),
    );
  }
}
