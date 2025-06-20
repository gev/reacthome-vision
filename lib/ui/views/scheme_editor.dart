import 'package:flutter/widgets.dart';
import 'package:studio/core/scheme.dart';
import 'package:studio/ui/painters/grid_painter.dart';
import 'package:studio/ui/painters/scheme_painter.dart';
import 'package:studio/ui/scheme/scheme_stage.dart';
import 'package:studio/ui/widgets/scheme_interactive_viewer.dart';
import 'package:studio/ui/widgets/scheme_paint.dart';
import 'package:studio/ui_kit/theme.dart';
import 'package:studio/ui_kit/theme/theme.dart';

const double gap = 100;

class SchemeEditor extends StatelessWidget {
  final Scheme scheme;

  const SchemeEditor({required this.scheme, super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return _SchemeEditor(items: scheme, theme: theme);
  }
}

class _SchemeEditor extends StatefulWidget {
  final Scheme items;
  final ThemeContainer theme;

  const _SchemeEditor({required this.items, required this.theme});

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
    stage = SchemeStage(scheme: widget.items, gap: gap, theme: widget.theme);
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
    if (widget.items != oldWidget.items || widget.theme != oldWidget.theme) {
      stage.dispose();
      stage = SchemeStage(scheme: widget.items, gap: gap, theme: widget.theme);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SchemePaint(
          painter: GridPainter(
            gap: gap,
            theme: widget.theme,
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
