import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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

class _VerticalSliderState extends State<VerticalSlider>
    with SingleTickerProviderStateMixin {
  late double _normalizedValue;
  late AnimationController _widthController;
  late Animation<double> _widthAnimation;

  double? _dragStartNormalized;
  double? _dragStartDy;

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

  // Создаем или обновляем анимацию
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
  void didUpdateWidget(covariant VerticalSlider oldWidget) {
    super.didUpdateWidget(oldWidget);

    // Обновляем value/min/max
    if (oldWidget.value != widget.value ||
        oldWidget.min != widget.min ||
        oldWidget.max != widget.max) {
      _normalizedValue = _toNormalized(
        widget.value.clamp(widget.min, widget.max),
      );
    }

    // Обновляем duration контроллера
    if (oldWidget.animationDuration != widget.animationDuration) {
      _widthController.duration = widget.animationDuration;
    }

    // Обновляем анимацию, если поменялись размеры или кривая
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

  void _handleDrag(Offset localPosition, Size currentSize) {
    double newNormalized;
    if (widget.jumpToTap) {
      newNormalized = (1.0 - (localPosition.dy / currentSize.height)).clamp(
        0.0,
        1.0,
      );
    } else {
      if (_dragStartNormalized == null || _dragStartDy == null) return;
      double deltaDy = _dragStartDy! - localPosition.dy;
      newNormalized = (_dragStartNormalized! + (deltaDy / currentSize.height))
          .clamp(0.0, 1.0);
    }

    if ((_normalizedValue - newNormalized).abs() > 0.0001) {
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
      onVerticalDragStart: (details) {
        _widthController.forward();
        _dragStartNormalized = _normalizedValue;
        _dragStartDy = details.localPosition.dy;
        if (widget.enableHapticOnTap) HapticFeedback.selectionClick();
      },
      onVerticalDragUpdate: (details) => _handleDrag(
        details.localPosition,
        Size(_widthAnimation.value, widget.height),
      ),
      onVerticalDragEnd: (_) => _widthController.reverse(),
      onVerticalDragCancel: () => _widthController.reverse(),
      onTapDown: (details) {
        _widthController.forward();
        _dragStartNormalized = _normalizedValue;
        _dragStartDy = details.localPosition.dy;
        if (widget.enableHapticOnTap) HapticFeedback.selectionClick();
        _handleDrag(
          details.localPosition,
          Size(_widthAnimation.value, widget.height),
        );
      },
      onTapUp: (_) => _widthController.reverse(),
      child: AnimatedBuilder(
        animation: _widthAnimation,
        builder: (context, _) => CustomPaint(
          size: Size(_widthAnimation.value, widget.height),
          painter: _SliderPainter(
            normalizedValue: _normalizedValue,
            min: widget.min,
            max: widget.max,
            activeColor: activeColor,
            inactiveColor: inactiveColor,
            borderRadius: widget.borderRadius,
            currentWidth: _widthAnimation.value,
            height: widget.height,
          ),
        ),
      ),
    );
  }
}

class _SliderPainter extends CustomPainter {
  final double normalizedValue;
  final double min;
  final double max;
  final Color activeColor;
  final Color inactiveColor;
  final double borderRadius;
  final double currentWidth;
  final double height;

  _SliderPainter({
    required this.normalizedValue,
    required this.min,
    required this.max,
    required this.activeColor,
    required this.inactiveColor,
    required this.borderRadius,
    required this.currentWidth,
    required this.height,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;
    final rrect = RRect.fromRectAndRadius(rect, Radius.circular(borderRadius));

    canvas.drawRRect(rrect, Paint()..color = inactiveColor);
    canvas.clipRRect(rrect);

    final activeHeight = size.height * normalizedValue;
    final activeRect = Rect.fromLTWH(
      0,
      size.height - activeHeight,
      size.width,
      activeHeight,
    );
    canvas.drawRect(activeRect, Paint()..color = activeColor);
  }

  @override
  bool shouldRepaint(_SliderPainter old) {
    return old.normalizedValue != normalizedValue ||
        old.min != min ||
        old.max != max ||
        old.activeColor != activeColor ||
        old.inactiveColor != inactiveColor ||
        old.borderRadius != borderRadius ||
        old.currentWidth != currentWidth ||
        old.height != height;
  }
}
