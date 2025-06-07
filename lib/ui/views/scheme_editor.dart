import 'package:flutter/widgets.dart';
import 'package:studio/scheme/element.dart';
import 'package:studio/ui/figures/figure.dart';
import 'package:studio/ui/painters/grid_painter.dart';
import 'package:studio/ui/painters/scheme_painter.dart';
import 'package:studio/ui/stages/scheme.dart';
import 'package:studio/ui/widgets/scheme_interactive_viewer.dart';
import 'package:studio/ui/widgets/scheme_paint.dart';
import 'package:studio/ui_kit/theme.dart';

const double gap = 100;

class SchemeEditor extends StatelessWidget {
  final Items items;

  const SchemeEditor({required this.items, super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final background = theme.backgroundColor!;
    final textStyle = theme.bodyStyle!;
    final labelStyle = textStyle.copyWith(
      color: textStyle.color!.withAlpha(80),
    );
    final axisStyle = paintStyle(
      style: PaintingStyle.stroke,
      color: labelStyle.color,
      strokeWidth: 0.5,
    );
    return _SchemeEditor(
      background: background,
      labelStyle: labelStyle,
      axisStyle: axisStyle,
      child: SchemePaint(
        painter: SchemePainter(
          scheme: Scheme(items: items, gap: gap, textStyle: textStyle),
        ),
      ),
    );
  }
}

class _SchemeEditor extends StatefulWidget {
  final Widget child;
  final Color background;
  final TextStyle labelStyle;
  final Paint axisStyle;

  const _SchemeEditor({
    required this.child,
    required this.background,
    required this.labelStyle,
    required this.axisStyle,
  });

  @override
  State<_SchemeEditor> createState() => _SchemeEditorState();
}

class _SchemeEditorState extends State<_SchemeEditor> {
  double scale = 1;
  Offset offset = const Offset(0, 0);
  final controller = TransformationController();

  @override
  void initState() {
    super.initState();
    controller.addListener(() {
      setState(() {
        final translation = controller.value.getTranslation();
        offset = Offset(translation[0], translation[1]);
        scale = controller.value.getMaxScaleOnAxis();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SchemePaint(
          painter: GridPainter(
            gap: gap,
            offset: offset,
            scale: scale,
            background: widget.background,
            labelStyle: widget.labelStyle,
            axisStyle: widget.axisStyle,
          ),
        ),
        SchemeInteractiveViewer(
          transformationController: controller,
          child: widget.child,
        ),
      ],
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
