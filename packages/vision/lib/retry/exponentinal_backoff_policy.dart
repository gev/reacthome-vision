import 'dart:math';

import 'package:vision/retry/dellayed_backoff_policy.dart';

class ExponentialBackoffPolicy extends DelayedBackoffPolicy {
  final int _maxDelay;

  ExponentialBackoffPolicy({
    Duration maxDelay = const Duration(seconds: 30),
    super.delay = const Duration(seconds: 1),
    super.attempts,
    super.random,
  }) : _maxDelay = maxDelay.inMilliseconds;

  @override
  int get nextDelay => min(currentDelay * 2, _maxDelay);
}
