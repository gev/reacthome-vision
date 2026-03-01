import 'dart:async';

import 'package:vision/glue/glue_evaluator.dart';

class GlueController {
  late final GlueEvaluator _evaluator;
  late final StreamSubscription<String> _subscription;

  GlueController({
    required GlueEvaluator evaluator,
    required Stream<String> source,
  }) {
    _evaluator = evaluator;
    _subscription = source.listen(_onData);
  }

  void _onData(String message) {
    _evaluator.evaluate(message);
  }

  void dispose() {
    _subscription.cancel();
  }
}
