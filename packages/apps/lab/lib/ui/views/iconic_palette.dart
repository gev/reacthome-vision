import 'package:flutter/widgets.dart';
import 'package:iconic/iconic_grid.dart';
import 'package:iconic/iconics.dart';
import 'package:iconic/scheme_icon.dart';
import 'package:ui_kit/widgets.dart';

class IconicPalette extends StatelessWidget {
  final bool shouldShowGrid;
  final double size;

  const IconicPalette({
    required this.size,
    required this.shouldShowGrid,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = UI.themeOf(context);
    return LayoutBuilder(
      builder: (context, constrains) {
        return SizedBox(
          width: constrains.maxWidth,
          child: SingleChildScrollView(
            child: Wrap(
              alignment: WrapAlignment.center,
              children: [
                for (final it in iconics)
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: theme.color.withAlpha(64)),
                      borderRadius: const BorderRadius.all(Radius.circular(20)),
                    ),
                    padding: const EdgeInsetsGeometry.all(20),
                    margin: const EdgeInsets.all(20),
                    child: Stack(
                      children: [
                        ?shouldShowGrid
                            ? SchemeIcon(
                                makeIconic: IconicGrid.new,
                                size: size,
                                color: theme.color.withAlpha(16),
                                strokeWidth: 0.01,
                              )
                            : null,
                        SchemeIcon(makeIconic: it, size: size),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}
