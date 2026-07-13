import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LeftCurtain extends StatefulWidget {
  final double value;
  final ValueChanged<double> onChanged;
  final bool translucent, jumpToTap, enableHapticOnTap, enableHapticOnBounds;
  final Color? activeColor, inactiveColor;
  final double width, height;
  final double frameRadius, edgeRadius, focusedRadius;
  final Duration animationDuration;
  final Curve animationCurve;

  const LeftCurtain({
    super.key,
    required this.value,
    required this.onChanged,
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
  State<LeftCurtain> createState() => _LeftCurtainState();
}

class _LeftCurtainState extends State<LeftCurtain>
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
  void didUpdateWidget(covariant LeftCurtain oldWidget) {
    super.didUpdateWidget(oldWidget);
    _controller.duration = widget.animationDuration;
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
    if (mounted) setState(() {});
  }

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
      setState(() => _normalizedValue = newNormalized);
      widget.onChanged(newNormalized);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return RawGestureDetector(
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
            size: Size(widget.width, widget.height),
            painter: _LeftCurtainPainter(
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
      ),
    );
  }
}

class _LeftCurtainPainter extends CustomPainter {
  final double val;
  final Color active, inactive;
  final double height, width, frameRadius, edgeRadius;
  final bool translucent;

  _LeftCurtainPainter(
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
      topLeft: Radius.circular(frameRadius),
      bottomLeft: Radius.circular(frameRadius),
      topRight: Radius.circular(frameRadius),
      bottomRight: Radius.circular(edgeRadius),
    );

    if (!translucent) {
      canvas.drawRRect(bgRRect, Paint()..color = inactive);
    }

    final minWidth = frameRadius + edgeRadius;
    final activeWidth = minWidth + (size.width - minWidth) * val;

    final activeRRect = RRect.fromRectAndCorners(
      Rect.fromLTWH(0, 0, activeWidth, size.height),
      topLeft: Radius.circular(frameRadius),
      bottomLeft: Radius.circular(frameRadius),
      topRight: Radius.circular(frameRadius),
      bottomRight: Radius.circular(edgeRadius),
    );

    canvas.save();
    canvas.clipRRect(bgRRect);
    canvas.drawRRect(activeRRect, Paint()..color = active);
    canvas.restore();

    final corniceRRect = RRect.fromRectAndCorners(
      Rect.fromLTWH(0, 0, size.width, frameRadius),
      topLeft: Radius.circular(frameRadius),
      topRight: Radius.circular(frameRadius),
    );

    canvas.drawRRect(corniceRRect, Paint()..color = active);
  }

  @override
  bool hitTest(Offset localPosition) {
    if (!translucent) return true;

    final minWidth = frameRadius + edgeRadius;
    final activeWidth = minWidth + (width - minWidth) * val;
    return localPosition.dx <= activeWidth && localPosition.dy <= height;
  }

  @override
  bool shouldRepaint(covariant _LeftCurtainPainter old) => true;
}

class _EagerHorizontalDragGestureRecognizer
    extends HorizontalDragGestureRecognizer {
  @override
  void addAllowedPointer(PointerDownEvent event) {
    super.addAllowedPointer(event);
    resolve(GestureDisposition.accepted);
  }
}
