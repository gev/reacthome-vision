import 'package:flutter/widgets.dart';
import 'package:scheme/core/scheme.dart';
import 'package:scheme/painters/grid_painter.dart';
import 'package:scheme/painters/scheme_painter.dart';
import 'package:scheme/stages/line.dart';
import 'package:scheme/stages/node.dart';
import 'package:scheme/stages/scheme_stage.dart';
import 'package:studio/ui/widgets/scheme_interactive_viewer.dart';
import 'package:studio/ui/widgets/scheme_paint.dart';
import 'package:ui_kit/widgets.dart';

const double gap = 100;

class SchemeEditor<Id> extends StatelessWidget {
  final Scheme<Id> scheme;

  const SchemeEditor({required this.scheme, super.key});

  @override
  Widget build(BuildContext context) {
    final theme = UI.themeOf(context);
    return _SchemeEditor(
      items: scheme,
      gridStyle: GridStyle(
        backgroundColor: theme.backgroundColor,
        labelStyle: theme.bodyStyle,
        axisStrokeWidth: theme.bodyStyle.fontSize!,
      ),
      schemeStyle: SchemeStyle(
        nodeStyle: NodeStyle(
          color: theme.color,
          backgroundColor: theme.backgroundColor,
          selectedColor: theme.color.withAlpha(128),
          focusedColor: theme.primaryColor,
        ),
        lineStyle: LineStyle(
          color: theme.color.withAlpha(192),
          backgroundColor: theme.backgroundColor,
          strokeWidth: 1.0,
        ),
      ),
    );
  }
}

class _SchemeEditor<Id> extends StatefulWidget {
  final Scheme<Id> items;
  final GridStyle gridStyle;
  final SchemeStyle schemeStyle;
  late final Nodes<Id> nodes;
  late final Lines<Id> lines;

  _SchemeEditor({
    required this.items,
    required this.gridStyle,
    required this.schemeStyle,
  }) {
    lines = Lines(scheme: items, gap: gap, style: schemeStyle.lineStyle);
    nodes = Nodes(scheme: items, gap: gap, style: schemeStyle.nodeStyle);
  }

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
      lines: widget.lines,
      nodes: widget.nodes,
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
        widget.gridStyle != oldWidget.gridStyle ||
        widget.schemeStyle != oldWidget.schemeStyle) {
      stage.dispose();
      stage = SchemeStage(
        scheme: widget.items,
        lines: widget.lines,
        nodes: widget.nodes,
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
            style: widget.gridStyle,
            controller: gridController,
          ),
        ),

        SchemeInteractiveViewer(
          transformationController: transformationController,
          onSelect: stage.hitTest,
          onDrag: stage.drag,
          onDragged: stage.dragged,
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
