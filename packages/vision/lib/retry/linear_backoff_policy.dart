import 'package:vision/retry/dellayed_backoff_policy.dart';

class LinearBackoffPolicy extends DelayedBackoffPolicy {
  LinearBackoffPolicy({
    super.delay = const Duration(seconds: 5),
    super.attempts,
    super.random,
  });

  @override
  int get nextDelay => currentDelay;
}
