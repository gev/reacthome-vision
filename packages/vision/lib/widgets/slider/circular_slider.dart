import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CircularSlider extends StatefulWidget {
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
  final double diameter; // Заменяет height
  final StrokeCap cap; // Заменяет borderRadius
  final double startAngle; // В радианах
  final double endAngle; // В радианах
  final Duration animationDuration;
  final Curve animationCurve;

  const CircularSlider({
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
    this.width = 10.0,
    this.focusedWidth = 20.0,
    required this.diameter,
    this.cap = StrokeCap.round,
    this.startAngle = -5 * pi / 4,
    this.endAngle = pi / 4,
    this.animationDuration = const Duration(milliseconds: 300),
    this.animationCurve = Curves.easeOutBack,
  });

  @override
  State<CircularSlider> createState() => _CircularSliderState();
}

class _CircularSliderState extends State<CircularSlider>
    with SingleTickerProviderStateMixin {
  late double _normalizedValue;
  late AnimationController _widthController;
  late Animation<double> _widthAnimation;

  @override
  void initState() {
    super.initState();
    _normalizedValue = _toNormalized(
      widget.value.clamp(widget.min, widget.max),
    );
    _widthController = AnimationController(
      vsync: this,
      duration: widget.animationDuration,
    );
    _updateAnimation();
  }

  void _updateAnimation() {
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
        oldWidget.max != widget.max) {
      _normalizedValue = _toNormalized(
        widget.value.clamp(widget.min, widget.max),
      );
    }
    if (oldWidget.animationDuration != widget.animationDuration) {
      _widthController.duration = widget.animationDuration;
    }
    if (oldWidget.width != widget.width ||
        oldWidget.focusedWidth != widget.focusedWidth ||
        oldWidget.animationCurve != widget.animationCurve) {
      _updateAnimation();
    }
  }

  @override
  void dispose() {
    _widthController.dispose();
    super.dispose();
  }

  double _toNormalized(double val) => widget.max == widget.min
      ? 0.0
      : ((val - widget.min) / (widget.max - widget.min)).clamp(0.0, 1.0);

  double _fromNormalized(double val) =>
      widget.min + (val * (widget.max - widget.min));

  void _handleInput(Offset localPosition, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final dx = localPosition.dx - center.dx;
    final dy = localPosition.dy - center.dy;

    // Получаем угол от -pi до pi
    double angle = atan2(dy, dx);

    // Нормализуем угол относительно startAngle
    double start = widget.startAngle;
    double sweep = widget.endAngle - widget.startAngle;

    // Сдвигаем текущий угол, чтобы начало было в 0
    double relativeAngle = angle - start;

    // Приводим к диапазону [0, 2*pi] для удобства расчетов
    while (relativeAngle < 0) relativeAngle += 2 * pi;
    while (relativeAngle >= 2 * pi) relativeAngle -= 2 * pi;

    // Ограничиваем с учетом sweep (дуги)
    double newNormalized = (relativeAngle / sweep).clamp(0.0, 1.0);

    if ((_normalizedValue - newNormalized).abs() > 0.001) {
      if (widget.enableHapticOnBounds &&
          ((newNormalized == 0.0 && _normalizedValue > 0.0) ||
              (newNormalized == 1.0 && _normalizedValue < 1.0))) {
        HapticFeedback.heavyImpact();
      }
      setState(() => _normalizedValue = newNormalized);
      widget.onChanged(_fromNormalized(newNormalized));
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final activeColor = widget.activeColor ?? theme.colorScheme.primary;
    final inactiveColor =
        widget.inactiveColor ?? theme.colorScheme.surfaceContainerHighest;

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onPanStart: (details) {
        _widthController.forward();
        if (widget.enableHapticOnTap) HapticFeedback.selectionClick();
        _handleInput(
          details.localPosition,
          Size(widget.diameter, widget.diameter),
        );
      },
      onPanUpdate: (details) => _handleInput(
        details.localPosition,
        Size(widget.diameter, widget.diameter),
      ),
      onPanEnd: (_) => _widthController.reverse(),
      onPanCancel: () => _widthController.reverse(),
      child: AnimatedBuilder(
        animation: _widthAnimation,
        builder: (context, _) => CustomPaint(
          size: Size(widget.diameter, widget.diameter),
          painter: _CircularSliderPainter(
            normalizedValue: _normalizedValue,
            activeColor: activeColor,
            inactiveColor: inactiveColor,
            strokeWidth: _widthAnimation.value,
            cap: widget.cap,
            startAngle: widget.startAngle,
            endAngle: widget.endAngle,
          ),
        ),
      ),
    );
  }
}

class _CircularSliderPainter extends CustomPainter {
  final double normalizedValue;
  final Color activeColor;
  final Color inactiveColor;
  final double strokeWidth;
  final StrokeCap cap;
  final double startAngle;
  final double endAngle;

  _CircularSliderPainter({
    required this.normalizedValue,
    required this.activeColor,
    required this.inactiveColor,
    required this.strokeWidth,
    required this.cap,
    required this.startAngle,
    required this.endAngle,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    // Радиус с учетом толщины линии, чтобы не вылезать за границы diameter
    final radius = (size.width / 2) - (strokeWidth / 2);
    final rect = Rect.fromCircle(center: center, radius: radius);

    final paintInactive = Paint()
      ..color = inactiveColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = cap;

    final paintActive = Paint()
      ..color = activeColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = cap;

    final sweep = endAngle - startAngle;

    // Фон (Inactive)
    canvas.drawArc(rect, startAngle, sweep, false, paintInactive);

    // Активная часть (Active)
    canvas.drawArc(
      rect,
      startAngle,
      sweep * normalizedValue,
      false,
      paintActive,
    );
  }

  @override
  bool shouldRepaint(_CircularSliderPainter old) {
    return old.normalizedValue != normalizedValue ||
        old.activeColor != activeColor ||
        old.inactiveColor != inactiveColor ||
        old.strokeWidth != strokeWidth ||
        old.cap != cap ||
        old.startAngle != startAngle ||
        old.endAngle != endAngle;
  }
}
