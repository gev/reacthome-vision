import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HorizontalSlider extends StatefulWidget {
  final double value;
  final ValueChanged<double>? onChanged;
  final double min, max;
  final bool jumpToTap, enableHapticOnTap, enableHapticOnBounds;
  final Color? activeColor, inactiveColor;
  final double width, height, focusedHeight, borderRadius;
  final Duration animationDuration;
  final Curve animationCurve;

  const HorizontalSlider({
    super.key,
    required this.value,
    this.onChanged,
    this.min = 0.0,
    this.max = 1.0,
    this.jumpToTap = true,
    this.enableHapticOnTap = true,
    this.enableHapticOnBounds = true,
    this.activeColor,
    this.inactiveColor,
    this.width = 250.0,
    this.height = 40.0,
    this.focusedHeight = 60.0,
    this.borderRadius = 20.0,
    this.animationDuration = const Duration(milliseconds: 300),
    this.animationCurve = Curves.easeOutBack,
  });

  @override
  State<HorizontalSlider> createState() => _HorizontalSliderState();
}

class _HorizontalSliderState extends State<HorizontalSlider>
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
  void didUpdateWidget(covariant HorizontalSlider oldWidget) {
    super.didUpdateWidget(oldWidget);
    _controller.duration = widget.animationDuration;
    _updateInternals();
  }

  void _updateInternals() {
    _normalizedValue = _toNormalized(
      widget.value.clamp(widget.min, widget.max),
    );
    _animation = Tween<double>(begin: widget.height, end: widget.focusedHeight)
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
      double delta = (localPosition.dx - _dragStartPos!) / widget.width;
      newNormalized = (_dragStartValue! + delta).clamp(0.0, 1.0);
    } else {
      newNormalized = (localPosition.dx / widget.width).clamp(0.0, 1.0);
    }

    if ((_normalizedValue - newNormalized).abs() > 0.0001) {
      if (widget.enableHapticOnBounds &&
          ((newNormalized == 0.0 && _normalizedValue > 0.0) ||
              (newNormalized == 1.0 && _normalizedValue < 1.0))) {
        HapticFeedback.heavyImpact();
      }
      widget.onChanged?.call(_fromNormalized(newNormalized));
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final slider = AnimatedBuilder(
      animation: _animation,
      builder: (c, _) => TweenAnimationBuilder<double>(
        tween: Tween<double>(end: _normalizedValue),
        duration: widget.animationDuration,
        curve: widget.animationCurve,
        builder: (c, val, _) => CustomPaint(
          size: Size(widget.width, _animation.value),
          painter: _SliderPainter(
            val,
            widget.activeColor ?? theme.colorScheme.primary,
            widget.inactiveColor ?? theme.colorScheme.surfaceContainerHighest,
            widget.borderRadius,
            true,
          ),
        ),
      ),
    );
    return widget.onChanged == null
        ? slider
        : RawGestureDetector(
            behavior: HitTestBehavior.opaque,
            gestures: {
              _EagerHorizontalDragGestureRecognizer:
                  GestureRecognizerFactoryWithHandlers<
                    _EagerHorizontalDragGestureRecognizer
                  >(() => _EagerHorizontalDragGestureRecognizer(), (instance) {
                    instance.onDown = (d) {
                      _dragHapticTriggered = false;
                      _controller.forward();
                      _dragStartValue = _normalizedValue;
                      _dragStartPos = d.localPosition.dx;
                      if (widget.jumpToTap) {
                        _handleInput(d.localPosition, isDrag: false);
                      }
                      if (widget.enableHapticOnTap) {
                        HapticFeedback.selectionClick();
                      }
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
            child: slider,
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

class _EagerHorizontalDragGestureRecognizer
    extends HorizontalDragGestureRecognizer {
  @override
  void addAllowedPointer(PointerDownEvent event) {
    super.addAllowedPointer(event);
    resolve(GestureDisposition.accepted);
  }
}
