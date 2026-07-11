import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

typedef ValueFormatter = String Function(double value);

class VerticalSlider extends StatefulWidget {
  final double value;
  final ValueChanged<double> onChanged;
  final double min;
  final double max;

  final bool jumpToTap;
  final bool enableHapticOnTap;
  final bool enableHapticOnBounds;

  final Color? activeColor;
  final Color? inactiveColor;

  final double width;
  final double focusedWidth;
  final double height;
  final double borderRadius;
  final Duration animationDuration;
  final Curve animationCurve;

  const VerticalSlider({
    super.key,
    required this.value,
    required this.onChanged,
    this.min = 0.0,
    this.max = 1.0,
    this.jumpToTap = true,
    this.enableHapticOnTap = true,
    this.enableHapticOnBounds = true,
    this.activeColor,
    this.inactiveColor,
    this.width = 40.0,
    this.focusedWidth = 60.0,
    this.height = 250.0,
    this.borderRadius = 20.0,
    this.animationDuration = const Duration(milliseconds: 300),
    this.animationCurve = Curves.easeOutBack,
  });

  @override
  State<VerticalSlider> createState() => _VerticalSliderState();
}

class _VerticalSliderState extends State<VerticalSlider> {
  late double _normalizedValue;
  bool _isFocused = false;

  double? _dragStartNormalized;
  double? _dragStartDy;

  @override
  void initState() {
    super.initState();
    _normalizedValue = _toNormalized(
      widget.value.clamp(widget.min, widget.max),
    );
  }

  @override
  void didUpdateWidget(covariant VerticalSlider oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.value != widget.value ||
        oldWidget.min != widget.min ||
        oldWidget.max != widget.max) {
      _normalizedValue = _toNormalized(
        widget.value.clamp(widget.min, widget.max),
      );
    }
  }

  double _toNormalized(double val) {
    if (widget.max == widget.min) return 0.0;
    return ((val - widget.min) / (widget.max - widget.min)).clamp(0.0, 1.0);
  }

  double _fromNormalized(double val) =>
      widget.min + (val * (widget.max - widget.min));

  void _handleDrag(Offset localPosition) {
    final RenderBox? box = context.findRenderObject() as RenderBox?;
    if (box == null) return;

    double newNormalized;
    if (widget.jumpToTap) {
      newNormalized = (1.0 - (localPosition.dy / box.size.height)).clamp(
        0.0,
        1.0,
      );
    } else {
      if (_dragStartNormalized == null || _dragStartDy == null) return;
      double deltaDy = _dragStartDy! - localPosition.dy;
      double progressDelta = deltaDy / box.size.height;
      newNormalized = (_dragStartNormalized! + progressDelta).clamp(0.0, 1.0);
    }

    if (_normalizedValue != newNormalized) {
      if (widget.enableHapticOnBounds) {
        if ((newNormalized == 0.0 && _normalizedValue > 0.0) ||
            (newNormalized == 1.0 && _normalizedValue < 1.0)) {
          HapticFeedback.heavyImpact();
        }
      }
      setState(() => _normalizedValue = newNormalized);
      widget.onChanged(_fromNormalized(newNormalized));
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    final activeColor = widget.activeColor ?? colorScheme.primary;
    final inactiveColor =
        widget.inactiveColor ?? colorScheme.surfaceContainerHighest;

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onVerticalDragStart: (details) {
        setState(() {
          _isFocused = true;
          _dragStartNormalized = _normalizedValue;
          _dragStartDy = details.localPosition.dy;
        });
        if (widget.enableHapticOnTap) HapticFeedback.selectionClick();
      },
      onVerticalDragUpdate: (details) => _handleDrag(details.localPosition),
      onVerticalDragEnd: (_) {
        setState(() => _isFocused = false);
        _dragStartNormalized = null;
        _dragStartDy = null;
      },
      onVerticalDragCancel: () {
        setState(() => _isFocused = false);
        _dragStartNormalized = null;
        _dragStartDy = null;
      },
      onTapDown: (details) {
        setState(() {
          _isFocused = true;
          _dragStartNormalized = _normalizedValue;
          _dragStartDy = details.localPosition.dy;
        });
        if (widget.enableHapticOnTap) HapticFeedback.selectionClick();
        _handleDrag(details.localPosition);
      },
      onTapUp: (_) => setState(() => _isFocused = false),
      child: AnimatedContainer(
        duration: widget.animationDuration,
        curve: widget.animationCurve,
        width: _isFocused ? widget.focusedWidth : widget.width,
        height: widget.height,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(widget.borderRadius),
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Container(color: inactiveColor),
              FractionallySizedBox(
                heightFactor: _normalizedValue,
                child: Container(color: activeColor),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
