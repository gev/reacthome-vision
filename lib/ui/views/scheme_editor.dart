import 'package:flutter/widgets.dart';
import 'package:studio/core/scheme.dart';
import 'package:studio/ui/figures/figure.dart';
import 'package:studio/ui/painters/grid_painter.dart';
import 'package:studio/ui/painters/scheme_painter.dart';
import 'package:studio/ui/stages/scheme_stage.dart';
import 'package:studio/ui/widgets/scheme_interactive_viewer.dart';
import 'package:studio/ui/widgets/scheme_paint.dart';
import 'package:studio/ui_kit/theme.dart';

const double gap = 100;

class SchemeEditor extends StatelessWidget {
  final Scheme scheme;

  const SchemeEditor({required this.scheme, super.key});

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
      items: scheme,
      background: background,
      axisStyle: axisStyle,
      labelStyle: labelStyle,
      textStyle: textStyle,
    );
  }
}

class _SchemeEditor extends StatefulWidget {
  final Scheme items;
  final Paint axisStyle;
  final Color background;
  final TextStyle labelStyle;
  final TextStyle textStyle;

  const _SchemeEditor({
    required this.items,
    required this.axisStyle,
    required this.background,
    required this.labelStyle,
    required this.textStyle,
  });

  @override
  State<_SchemeEditor> createState() => _SchemeEditorState();
}

class _SchemeEditorState extends State<_SchemeEditor> {
  late SchemeStage stage;
  late GridController gridController;
  late TransformationController transformationController;

  @override
  void initState() {
    super.initState();
    stage = SchemeStage(
      scheme: widget.items,
      gap: gap,
      textStyle: widget.textStyle,
    );
    gridController = GridController();
    transformationController = TransformationController();
    transformationController.addListener(() {
      final translation = transformationController.value.getTranslation();
      final offset = Offset(translation[0], translation[1]);
      final scale = transformationController.value.getMaxScaleOnAxis();
      gridController.update(offset, scale);
    });
  }

  @override
  void didUpdateWidget(covariant _SchemeEditor oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.items != oldWidget.items ||
        widget.textStyle != oldWidget.textStyle) {
      stage.dispose();
      stage = SchemeStage(
        scheme: widget.items,
        gap: gap,
        textStyle: widget.textStyle,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SchemePaint(
          painter: GridPainter(
            gap: gap,
            background: widget.background,
            labelStyle: widget.labelStyle,
            axisStyle: widget.axisStyle,
            controller: gridController,
          ),
        ),

        SchemeInteractiveViewer(
          transformationController: transformationController,
          onSelect: stage.hitTest,
          onDrag: stage.drag,
          child: SchemePaint(painter: SchemePainter(scheme: stage)),
        ),
      ],
    );
  }

  @override
  void dispose() {
    transformationController.dispose();
    gridController.dispose();
    stage.dispose();
    super.dispose();
  }
}
