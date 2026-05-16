import 'package:vision/retry/retry.dart';

class ImediatlyPolicy implements RetryPolicy {
  @override
  void reset() {}

  @override
  Future<bool> get shouldRetry async => true;
}
