import 'dart:math';

import 'package:vision/retry/retry.dart';

abstract class DelayedBackoffPolicy implements RetryPolicy {
  int get currentDelay => _currentDelay;
  int get nextDelay;

  final int _initialDelay;
  final int _attempts;
  final Random _random;

  int _currentDelay;
  int _currentAttempt = 0;

  int get _jitter {
    final jitterRange = (_currentDelay * 0.2).toInt();
    return _random.nextInt(jitterRange * 2 + 1) - jitterRange;
  }

  DelayedBackoffPolicy({
    required Duration delay,
    int attempts = 0,
    Random? random,
  }) : _initialDelay = delay.inMilliseconds,
       _currentDelay = delay.inMilliseconds,
       _attempts = attempts,
       _random = random ?? Random();

  @override
  void reset() {
    _currentAttempt = 0;
    _currentDelay = _initialDelay;
  }

  @override
  Future<bool> get shouldRetry async {
    if (_attempts > 0 && _currentAttempt >= _attempts) {
      return false;
    }
    final delay = max(0, _currentDelay + _jitter);
    await Future.delayed(Duration(milliseconds: delay));
    _currentDelay = nextDelay;
    _currentAttempt++;
    return true;
  }
}
