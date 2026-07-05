import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class VerticalSlider extends StatefulWidget {
  final double value;
  final ValueChanged<double> onChanged;
  final double? secondaryTrackValue; // Вернул на место

  final Color? activeColor;
  final Color? inactiveColor;
  final Color? secondaryActiveColor;

  final double width;
  final double focusedWidth;
  final double height;
  final double borderRadius;
  final Duration animationDuration;
  final Curve animationCurve;

  final Widget? topWidget;
  final Widget? bottomWidget;
  final Widget? centerWidget;

  const VerticalSlider({
    super.key,
    required this.value,
    required this.onChanged,
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
    this.topWidget,
    this.bottomWidget,
    this.centerWidget,
  });

  @override
  State<VerticalSlider> createState() => _VerticalSliderState();
}

class _VerticalSliderState extends State<VerticalSlider> {
  late double _value;
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
    _value = widget.value.clamp(0.0, 1.0);
  }

  @override
  void didUpdateWidget(covariant VerticalSlider oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.value != widget.value) {
      _value = widget.value.clamp(0.0, 1.0);
    }
  }

  void _handleDrag(Offset localPosition) {
    final RenderBox? box = context.findRenderObject() as RenderBox?;
    if (box == null) return;

    double newProgress = (1.0 - (localPosition.dy / box.size.height)).clamp(
      0.0,
      1.0,
    );

    setState(() {
      _value = newProgress;
    });

    widget.onChanged(newProgress);
    HapticFeedback.selectionClick();
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

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onVerticalDragStart: (_) => setState(() => _isFocused = true),
      onVerticalDragEnd: (_) => setState(() => _isFocused = false),
      onVerticalDragCancel: () => setState(() => _isFocused = false),
      onVerticalDragUpdate: (details) => _handleDrag(details.localPosition),
      onTapDown: (details) {
        setState(() => _isFocused = true);
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

              // ВЕРНУЛ СЕКОНДАРИ ТРЕК
              if (widget.secondaryTrackValue != null)
                FractionallySizedBox(
                  heightFactor: widget.secondaryTrackValue!.clamp(0.0, 1.0),
                  child: Container(color: secondaryColor),
                ),

              FractionallySizedBox(
                heightFactor: _value,
                child: Container(color: activeColor),
              ),

              if (widget.topWidget != null)
                Positioned(top: 12, child: widget.topWidget!),
              if (widget.bottomWidget != null)
                Positioned(bottom: 12, child: widget.bottomWidget!),
              if (widget.centerWidget != null)
                Center(
                  child: AnimatedOpacity(
                    duration: widget.animationDuration,
                    opacity: _isFocused ? 1.0 : 0.0,
                    child: widget.centerWidget!,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
