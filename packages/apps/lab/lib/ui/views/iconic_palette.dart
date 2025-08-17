import 'package:flutter/widgets.dart';
import 'package:iconic/iconics.dart';
import 'package:iconic/scheme_icon.dart';

class IconicPalette extends StatelessWidget {
  final double size;

  const IconicPalette({required this.size, super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constrains) {
        return SizedBox(
          width: constrains.maxWidth,
          child: SingleChildScrollView(
            child: Wrap(
              children: [
                for (final it in iconics)
                  Padding(
                    padding: const EdgeInsetsGeometry.all(20),
                    child: SchemeIcon(makeIconic: it, size: size),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}
