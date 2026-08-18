import 'dart:math' as math;

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CircularSlider extends StatefulWidget {
  final double value;
  final ValueChanged<double>? onChanged;
  final double min;
  final double max;
  final double diameter;
  final double width;
  final double focusedWidth;
  final double startAngle;
  final double endAngle;
  final Color? activeColor;
  final Color? inactiveColor;
  final StrokeCap cap;
  final Duration animationDuration;
  final Curve animationCurve;
  final bool jumpToTap;
  final bool enableHapticOnTap;
  final bool enableHapticOnBounds;

  const CircularSlider({
    super.key,
    required this.value,
    required this.diameter,
    this.onChanged,
    this.min = 0.0,
    this.max = 1.0,
    this.width = 24.0,
    this.focusedWidth = 36.0,
    this.startAngle = -math.pi * 1.25,
    this.endAngle = math.pi * 0.25,
    this.activeColor,
    this.inactiveColor,
    this.cap = StrokeCap.round,
    this.animationDuration = const Duration(milliseconds: 300),
    this.animationCurve = Curves.easeOutBack,
    this.jumpToTap = true,
    this.enableHapticOnTap = true,
    this.enableHapticOnBounds = true,
  }) : assert(startAngle < endAngle, 'startAngle must be less than endAngle');

  @override
  State<CircularSlider> createState() => _CircularSliderState();
}

class _CircularSliderState extends State<CircularSlider>
    with SingleTickerProviderStateMixin {
  late AnimationController _widthController;
  late Animation<double> _widthAnimation;

  late double _pureNormalizedValue;
  double? _lastRawAngle;
  bool _dragHapticTriggered = false;

  @override
  void initState() {
    super.initState();
    _pureNormalizedValue = _toNormalized(widget.value);

    _widthController = AnimationController(
      vsync: this,
      duration: widget.animationDuration,
    );

    _updateWidthAnimation();
  }

  void _updateWidthAnimation() {
    _widthAnimation =
        Tween<double>(begin: widget.width, end: widget.focusedWidth).animate(
          CurvedAnimation(
            parent: _widthController,
            curve: widget.animationCurve,
          ),
        );
  }

  @override
  void didUpdateWidget(covariant CircularSlider oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.value != widget.value ||
        oldWidget.min != widget.min ||
        oldWidget.max != widget.max) {}

    if (oldWidget.width != widget.width ||
        oldWidget.focusedWidth != widget.focusedWidth ||
        oldWidget.animationDuration != widget.animationDuration ||
        oldWidget.animationCurve != widget.animationCurve) {
      _widthController.duration = widget.animationDuration;
      _updateWidthAnimation();
    }
  }

  @override
  void dispose() {
    _widthController.dispose();
    super.dispose();
  }

  double _toNormalized(double val) {
    if (widget.max == widget.min) return 0.0;
    return ((val.clamp(widget.min, widget.max) - widget.min) /
            (widget.max - widget.min))
        .clamp(0.0, 1.0);
  }

  double _fromNormalized(double normalized) {
    return widget.min + normalized.clamp(0.0, 1.0) * (widget.max - widget.min);
  }

  void _handleInput(
    Offset localPosition, {
    bool isTap = false,
    bool resetLastAngle = false,
  }) {
    if (resetLastAngle) _lastRawAngle = null;
    if (isTap && !widget.jumpToTap) return;

    final center = Offset(widget.diameter / 2, widget.diameter / 2);
    final dx = localPosition.dx - center.dx;
    final dy = localPosition.dy - center.dy;

    double touchAngle = math.atan2(dy, dx);

    // Логика компенсации скачка при прохождении центра (разреза)
    if (!isTap && _lastRawAngle != null) {
      double delta = touchAngle - _lastRawAngle!;
      if (delta > math.pi) {
        touchAngle -= 2 * math.pi;
      } else if (delta < -math.pi) {
        touchAngle += 2 * math.pi;
      }
    }
    _lastRawAngle = touchAngle;

    double relativeAngle = touchAngle - widget.startAngle;
    relativeAngle = relativeAngle % (2 * math.pi);
    if (relativeAngle < 0) relativeAngle += 2 * math.pi;

    double sweep = widget.endAngle - widget.startAngle;

    double newNormalized;
    if (relativeAngle > sweep) {
      newNormalized = (relativeAngle - sweep) < (2 * math.pi - relativeAngle)
          ? 1.0
          : 0.0;
    } else {
      newNormalized = (relativeAngle / sweep).clamp(0.0, 1.0);
    }

    if ((_pureNormalizedValue - newNormalized).abs() > 0.001) {
      if (widget.enableHapticOnBounds &&
          ((newNormalized == 0.0 && _pureNormalizedValue > 0.0) ||
              (newNormalized == 1.0 && _pureNormalizedValue < 1.0))) {
        HapticFeedback.heavyImpact();
      }

      widget.onChanged?.call(_fromNormalized(newNormalized));
    }

    if (isTap && widget.enableHapticOnTap) {
      HapticFeedback.selectionClick();
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AnimatedBuilder(
      animation: _widthAnimation,
      builder: (context, child) {
        return TweenAnimationBuilder<double>(
          tween: Tween<double>(end: _pureNormalizedValue),
          duration: widget.animationDuration,
          curve: widget.animationCurve,
          builder: (context, animatedValue, _) {
            final slider = CustomPaint(
              size: Size(widget.diameter, widget.diameter),
              painter: _SliderPainter(
                normalizedValue: animatedValue,
                startAngle: widget.startAngle,
                endAngle: widget.endAngle,
                strokeWidth: _widthAnimation.value,
                activeColor: widget.activeColor ?? theme.colorScheme.primary,
                inactiveColor:
                    widget.inactiveColor ??
                    theme.colorScheme.surfaceContainerHighest,
                cap: widget.cap,
              ),
            );
            return widget.onChanged == null
                ? slider
                : RawGestureDetector(
                    behavior: HitTestBehavior.opaque,
                    gestures: {
                      _EagerPanGestureRecognizer:
                          GestureRecognizerFactoryWithHandlers<
                            _EagerPanGestureRecognizer
                          >(() => _EagerPanGestureRecognizer(), (
                            _EagerPanGestureRecognizer instance,
                          ) {
                            instance
                              ..onDown = (d) {
                                _dragHapticTriggered = false;
                                _widthController.forward();
                                if (widget.jumpToTap) {
                                  _handleInput(
                                    d.localPosition,
                                    isTap: true,
                                    resetLastAngle: true,
                                  );
                                } else {
                                  if (widget.enableHapticOnTap) {
                                    HapticFeedback.selectionClick();
                                  }
                                }
                              }
                              ..onStart = (d) {
                                _handleInput(
                                  d.localPosition,
                                  resetLastAngle: true,
                                );
                              }
                              ..onUpdate = (d) {
                                if (!_dragHapticTriggered &&
                                    widget.enableHapticOnTap) {
                                  HapticFeedback.selectionClick();
                                  _dragHapticTriggered = true;
                                }
                                _handleInput(d.localPosition);
                              }
                              ..onEnd = (_) {
                                _widthController.reverse();
                              }
                              ..onCancel = () {
                                _widthController.reverse();
                              };
                          }),
                    },
                    child: slider,
                  );
          },
        );
      },
    );
  }
}

class _SliderPainter extends CustomPainter {
  final double normalizedValue;
  final double startAngle;
  final double endAngle;
  final double strokeWidth;
  final Color activeColor;
  final Color inactiveColor;
  final StrokeCap cap;

  _SliderPainter({
    required this.normalizedValue,
    required this.startAngle,
    required this.endAngle,
    required this.strokeWidth,
    required this.activeColor,
    required this.inactiveColor,
    required this.cap,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);

    final maxPossibleWidth = math.max(strokeWidth, 36.0);
    final radius = (size.width / 2) - (maxPossibleWidth / 2);

    final rect = Rect.fromCircle(center: center, radius: radius);
    final sweep = endAngle - startAngle;

    final pBg = Paint()
      ..color = inactiveColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = cap;
    final pAc = Paint()
      ..color = activeColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = cap;

    canvas.drawArc(rect, startAngle, sweep, false, pBg);

    double activeSweep = sweep * normalizedValue.clamp(0.0, 1.0);

    if (activeSweep.abs() > 0.0001) {
      canvas.drawArc(rect, startAngle, activeSweep, false, pAc);
    }
  }

  @override
  bool shouldRepaint(_SliderPainter old) => true;
}

class _EagerPanGestureRecognizer extends PanGestureRecognizer {
  @override
  void addAllowedPointer(PointerDownEvent event) {
    super.addAllowedPointer(event);
    resolve(GestureDisposition.accepted);
  }

  @override
  String get debugDescription => 'eagerPan';
}
