import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class VerticalSlider extends StatefulWidget {
  final double value;
  final ValueChanged<double> onChanged;
  final double min, max;
  final bool jumpToTap, enableHapticOnTap, enableHapticOnBounds;
  final Color? activeColor, inactiveColor;
  final double width, focusedWidth, height, borderRadius;
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

class _VerticalSliderState extends State<VerticalSlider>
    with SingleTickerProviderStateMixin {
  late double _normalizedValue;
  late AnimationController _controller;
  late Animation<double> _animation;

  double? _dragStartValue;
  double? _dragStartPos;
  bool _dragHapticTriggered = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.animationDuration,
    );
    _updateInternals();
  }

  @override
  void didUpdateWidget(covariant VerticalSlider oldWidget) {
    super.didUpdateWidget(oldWidget);
    _controller.duration = widget.animationDuration;
    _updateInternals();
  }

  void _updateInternals() {
    _normalizedValue = _toNormalized(
      widget.value.clamp(widget.min, widget.max),
    );
    _animation = Tween<double>(begin: widget.width, end: widget.focusedWidth)
        .animate(
          CurvedAnimation(parent: _controller, curve: widget.animationCurve),
        );
  }

  double _toNormalized(double v) => widget.max == widget.min
      ? 0.0
      : ((v - widget.min) / (widget.max - widget.min)).clamp(0.0, 1.0);
  double _fromNormalized(double v) =>
      widget.min + (v * (widget.max - widget.min));

  void _handleInput(Offset localPosition, {bool isDrag = false}) {
    double newNormalized;
    if (isDrag &&
        !widget.jumpToTap &&
        _dragStartValue != null &&
        _dragStartPos != null) {
      double delta = (_dragStartPos! - localPosition.dy) / widget.height;
      newNormalized = (_dragStartValue! + delta).clamp(0.0, 1.0);
    } else {
      newNormalized = (1.0 - (localPosition.dy / widget.height)).clamp(
        0.0,
        1.0,
      );
    }

    if ((_normalizedValue - newNormalized).abs() > 0.0001) {
      if (widget.enableHapticOnBounds &&
          ((newNormalized == 0.0 && _normalizedValue > 0.0) ||
              (newNormalized == 1.0 && _normalizedValue < 1.0))) {
        HapticFeedback.heavyImpact();
      }
      widget.onChanged(_fromNormalized(newNormalized));
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return RawGestureDetector(
      behavior: HitTestBehavior.opaque,
      gestures: {
        _EagerVerticalDragGestureRecognizer:
            GestureRecognizerFactoryWithHandlers<
              _EagerVerticalDragGestureRecognizer
            >(() => _EagerVerticalDragGestureRecognizer(), (instance) {
              instance.onDown = (d) {
                _dragHapticTriggered = false;
                _controller.forward();
                _dragStartValue = _normalizedValue;
                _dragStartPos = d.localPosition.dy;
                if (widget.jumpToTap) {
                  _handleInput(d.localPosition, isDrag: false);
                }
                if (widget.enableHapticOnTap) HapticFeedback.selectionClick();
              };
              instance.onStart = (d) {
                _handleInput(d.localPosition, isDrag: true);
              };
              instance.onUpdate = (d) {
                if (!_dragHapticTriggered && widget.enableHapticOnTap) {
                  HapticFeedback.selectionClick();
                  _dragHapticTriggered = true;
                }
                _handleInput(d.localPosition, isDrag: true);
              };
              instance.onEnd = (_) {
                _controller.reverse();
              };
              instance.onCancel = () {
                _controller.reverse();
              };
            }),
      },
      child: AnimatedBuilder(
        animation: _animation,
        builder: (c, _) => TweenAnimationBuilder<double>(
          tween: Tween<double>(end: _normalizedValue),
          duration: widget.animationDuration,
          curve: widget.animationCurve,
          builder: (c, val, _) => CustomPaint(
            size: Size(_animation.value, widget.height),
            painter: _SliderPainter(
              val,
              widget.activeColor ?? theme.colorScheme.primary,
              widget.inactiveColor ?? theme.colorScheme.surfaceContainerHighest,
              widget.borderRadius,
              false,
            ),
          ),
        ),
      ),
    );
  }
}

class _SliderPainter extends CustomPainter {
  final double val;
  final Color active, inactive;
  final double radius;
  final bool horizontal;
  _SliderPainter(
    this.val,
    this.active,
    this.inactive,
    this.radius,
    this.horizontal,
  );
  @override
  void paint(Canvas canvas, Size size) {
    final rrect = RRect.fromRectAndRadius(
      Offset.zero & size,
      Radius.circular(radius),
    );
    canvas.drawRRect(rrect, Paint()..color = inactive);
    final rect = horizontal
        ? Rect.fromLTWH(0, 0, size.width * val, size.height)
        : Rect.fromLTWH(
            0,
            size.height - (size.height * val),
            size.width,
            size.height * val,
          );
    canvas.save();
    canvas.clipRRect(rrect);
    canvas.drawRect(rect, Paint()..color = active);
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant _SliderPainter old) => true;
}

class _EagerVerticalDragGestureRecognizer
    extends VerticalDragGestureRecognizer {
  @override
  void addAllowedPointer(PointerDownEvent event) {
    super.addAllowedPointer(event);
    resolve(GestureDisposition.accepted);
  }
}
