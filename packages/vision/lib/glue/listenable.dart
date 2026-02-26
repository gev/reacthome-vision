import 'package:flutter/material.dart';
import 'package:glue/eval.dart';
import 'package:glue/ir.dart';
import 'package:glue/runtime.dart';
import 'package:vision/glue/extract.dart';
import 'package:vision/store/state_notifier.dart';

class Listenable extends StatefulWidget {
  final StateNotifier<Ir> notifier;
  final Ir lambda;
  final Runtime runtime;

  const Listenable({
    required this.notifier,
    required this.lambda,
    required this.runtime,
    super.key,
  });

  @override
  State<Listenable> createState() => _ListenableState();
}

class _ListenableState extends State<Listenable> {
  Widget _cachedWidget = CircularProgressIndicator();

  @override
  void initState() {
    super.initState();
    widget.notifier.addListener(_updateWidget);
    _updateWidget(); // Initial evaluation
  }

  @override
  void didUpdateWidget(Listenable oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.notifier != widget.notifier) {
      oldWidget.notifier.removeListener(_updateWidget);
      widget.notifier.addListener(_updateWidget);
    }
  }

  @override
  void dispose() {
    widget.notifier.removeListener(_updateWidget);
    super.dispose();
  }

  void _updateWidget() async {
    // Get current value from StateNotifier
    final stateNotifier = widget.notifier;
    final currentValue = stateNotifier.value;

    // Call lambda with current value
    final result = await runEval(
      apply(widget.lambda, [currentValue]),
      widget.runtime,
    );
    final newWidget = result.match(
      (error) => _cachedWidget,
      (value) => extractWidget(value.$1),
    );
    if (mounted) {
      setState(() => _cachedWidget = newWidget);
    }
  }

  @override
  Widget build(BuildContext context) {
    return _cachedWidget;
  }
}
