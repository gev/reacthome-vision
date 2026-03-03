import 'package:flutter/widgets.dart';
import 'package:vision/glue/glue_evaluator.dart';
import 'package:vision/websocket/websocket_client.dart';

class VisionScope extends InheritedWidget {
  final WebSocketClient client;
  final GlueEvaluator evaluator;

  const VisionScope({
    super.key,
    required this.client,
    required this.evaluator,
    required super.child,
  });

  static VisionScope of(BuildContext context) {
    final scope = context.dependOnInheritedWidgetOfExactType<VisionScope>();
    assert(scope != null, 'No VisionScope found in context');
    return scope!;
  }

  @override
  bool updateShouldNotify(VisionScope oldWidget) {
    return client != oldWidget.client || evaluator != oldWidget.evaluator;
  }
}
