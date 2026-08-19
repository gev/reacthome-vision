import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class RightGate extends StatefulWidget {
  final double value;
  final ValueChanged<double>? onChanged;
  final bool translucent, jumpToTap, enableHapticOnTap, enableHapticOnBounds;
  final Color? activeColor, inactiveColor;
  final double width, height;
  final double frameRadius, edgeRadius, focusedRadius;
  final Duration animationDuration;
  final Curve animationCurve;

  const RightGate({
    super.key,
    required this.value,
    this.onChanged,
    this.translucent = false,
    this.jumpToTap = true,
    this.enableHapticOnTap = true,
    this.enableHapticOnBounds = true,
    this.activeColor,
    this.inactiveColor,
    this.width = 250.0,
    this.height = 160.0,
    this.frameRadius = 4.0,
    this.edgeRadius = 16.0,
    this.focusedRadius = 32.0,
    this.animationDuration = const Duration(milliseconds: 300),
    this.animationCurve = Curves.easeOutBack,
  });

  @override
  State<RightGate> createState() => _RightGateState();
}

class _RightGateState extends State<RightGate>
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
  void didUpdateWidget(covariant RightGate oldWidget) {
    super.didUpdateWidget(oldWidget);
    _updateInternals();
  }

  void _updateInternals() {
    _normalizedValue = widget.value.clamp(0.0, 1.0);
    _animation =
        Tween<double>(
          begin: widget.edgeRadius,
          end: widget.focusedRadius,
        ).animate(
          CurvedAnimation(parent: _controller, curve: widget.animationCurve),
        );
  }

  void _handleInput(Offset localPosition, {bool isDrag = false}) {
    double newNormalized;
    if (isDrag &&
        !widget.jumpToTap &&
        _dragStartValue != null &&
        _dragStartPos != null) {
      double delta = (_dragStartPos! - localPosition.dx) / widget.width;
      newNormalized = (_dragStartValue! + delta).clamp(0.0, 1.0);
    } else {
      newNormalized = (1.0 - (localPosition.dx / widget.width)).clamp(0.0, 1.0);
    }

    if ((_normalizedValue - newNormalized).abs() > 0.0001) {
      if (widget.enableHapticOnBounds &&
          ((newNormalized == 0.0 && _normalizedValue > 0.0) ||
              (newNormalized == 1.0 && _normalizedValue < 1.0))) {
        HapticFeedback.heavyImpact();
      }
      widget.onChanged?.call(newNormalized);
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
          size: Size(widget.width, widget.height),
          painter: _RightCurtainPainter(
            val,
            widget.activeColor ?? theme.colorScheme.primary,
            widget.inactiveColor ?? theme.colorScheme.surfaceContainerHighest,
            widget.height,
            widget.width,
            widget.frameRadius,
            _animation.value,
            widget.translucent,
          ),
        ),
      ),
    );
    return widget.onChanged == null
        ? slider
        : RawGestureDetector(
            behavior: widget.translucent
                ? HitTestBehavior.deferToChild
                : HitTestBehavior.opaque,
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

class _RightCurtainPainter extends CustomPainter {
  final double val;
  final Color active, inactive;
  final double height, width, frameRadius, edgeRadius;
  final bool translucent;

  _RightCurtainPainter(
    this.val,
    this.active,
    this.inactive,
    this.height,
    this.width,
    this.frameRadius,
    this.edgeRadius,
    this.translucent,
  );

  @override
  void paint(Canvas canvas, Size size) {
    final bgRRect = RRect.fromRectAndCorners(
      Offset.zero & size,
      topLeft: Radius.circular(edgeRadius),
      topRight: Radius.circular(frameRadius),
      bottomRight: Radius.circular(frameRadius),
      bottomLeft: Radius.circular(edgeRadius),
    );

    if (!translucent) {
      canvas.drawRRect(bgRRect, Paint()..color = inactive);
    }

    final minWidth = frameRadius + edgeRadius;
    final activeWidth = minWidth + (size.width - minWidth) * val;

    final activeRRect = RRect.fromRectAndCorners(
      Rect.fromLTWH(size.width - activeWidth, 0, activeWidth, size.height),
      topRight: Radius.circular(frameRadius),
      bottomRight: Radius.circular(frameRadius),
      topLeft: Radius.circular(edgeRadius),
      bottomLeft: Radius.circular(edgeRadius),
    );

    canvas.save();
    canvas.clipRRect(bgRRect);
    canvas.drawRRect(activeRRect, Paint()..color = active);
    canvas.restore();
  }

  @override
  bool hitTest(Offset localPosition) {
    if (!translucent) return true;

    final minWidth = frameRadius + edgeRadius;
    final activeWidth = minWidth + (width - minWidth) * val;
    return localPosition.dx >= (width - activeWidth) &&
        localPosition.dy <= height;
  }

  @override
  bool shouldRepaint(covariant _RightCurtainPainter old) => true;
}

class _EagerHorizontalDragGestureRecognizer
    extends HorizontalDragGestureRecognizer {
  @override
  void addAllowedPointer(PointerDownEvent event) {
    super.addAllowedPointer(event);
    resolve(GestureDisposition.accepted);
  }
}
