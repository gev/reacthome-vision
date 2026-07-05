import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

typedef ValueFormatter = String Function(double value);

class VerticalSlider extends StatefulWidget {
  final double value;
  final ValueChanged<double> onChanged;
  final double min;
  final double max;

  final bool displayValue;
  final ValueFormatter? valueLabelFormatter;

  final bool jumpToTap;
  final bool enableHapticOnTap;
  final bool enableHapticOnBounds;

  final double? secondaryTrackValue;
  final Color? activeColor;
  final Color? inactiveColor;
  final Color? secondaryActiveColor;

  final double width;
  final double focusedWidth;
  final double height;
  final double borderRadius;
  final Duration animationDuration;
  final Curve animationCurve;

  final Widget? icon;

  const VerticalSlider({
    super.key,
    required this.value,
    required this.onChanged,
    this.min = 0.0,
    this.max = 1.0,
    this.displayValue = true,
    this.valueLabelFormatter,
    this.jumpToTap = true,
    this.enableHapticOnTap = true,
    this.enableHapticOnBounds = true,
    this.secondaryTrackValue,
    this.activeColor,
    this.inactiveColor,
    this.secondaryActiveColor,
    this.width = 40.0,
    this.focusedWidth = 60.0,
    this.height = 250.0,
    this.borderRadius = 20.0,
    this.animationDuration = const Duration(milliseconds: 300),
    this.animationCurve = Curves.easeOutBack,
    this.icon,
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
    final sliderTheme = theme.sliderTheme;

    final activeColor =
        widget.activeColor ??
        sliderTheme.activeTrackColor ??
        colorScheme.primary;
    final inactiveColor =
        widget.inactiveColor ??
        sliderTheme.inactiveTrackColor ??
        colorScheme.surfaceContainerHighest;
    final secondaryColor =
        widget.secondaryActiveColor ??
        sliderTheme.secondaryActiveTrackColor ??
        colorScheme.primary.withValues(alpha: 0.38);

    final double realValue = _fromNormalized(_normalizedValue);

    Widget? valueContent;
    if (widget.displayValue) {
      valueContent = Text(
        widget.valueLabelFormatter?.call(realValue) ??
            realValue.toStringAsFixed(0),
        style: TextStyle(
          color: colorScheme.onPrimary,
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      );
    }

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
              if (widget.secondaryTrackValue != null)
                FractionallySizedBox(
                  heightFactor: _toNormalized(
                    widget.secondaryTrackValue!.clamp(widget.min, widget.max),
                  ),
                  child: Container(color: secondaryColor),
                ),
              FractionallySizedBox(
                heightFactor: _normalizedValue,
                child: Container(color: activeColor),
              ),

              if (widget.icon != null)
                Positioned(bottom: 12, child: widget.icon!),

              if (valueContent != null)
                FractionallySizedBox(
                  heightFactor: _normalizedValue,
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 12),
                      child: AnimatedOpacity(
                        duration: widget.animationDuration,
                        opacity: _isFocused ? 1.0 : 0.0,
                        child: valueContent,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
