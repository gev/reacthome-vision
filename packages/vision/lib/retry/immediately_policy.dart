import 'package:vision/retry/retry.dart';

class ImmediatelyPolicy implements RetryPolicy {
  @override
  void reset() {}

  @override
  Future<bool> get shouldRetry async => true;
}
