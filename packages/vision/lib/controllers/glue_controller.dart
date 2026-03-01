import 'dart:async';

import 'package:vision/glue/env.dart';
import 'package:vision/glue/glue_evaluator.dart';

class GlueController {
  late final GlueEvaluator _evaluator;
  late final StreamSubscription<String> _subscription;

  GlueController({required Sink<String> sink, required Stream<String> source}) {
    _evaluator = GlueEvaluator(makeEnv(sink));
    _subscription = source.listen(_onData);
  }

  void _onData(String message) {
    _evaluator.evaluate(message);
  }

  void dispose() {
    _subscription.cancel();
  }
}
