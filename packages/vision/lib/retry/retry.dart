import 'dart:async';

abstract interface class RetryPolicy {
  void reset();
  Future<bool> get shouldRetry;
}

abstract interface class Retryable {
  Future<bool> init();
  Future<void> run();
}

class Retry {
  final Retryable process;
  final RetryPolicy policy;

  var _isRuning = false;

  Retry({required this.process, required this.policy});

  Future<void> start() async {
    if (!_isRuning) {
      _isRuning = true;
      if (await process.init()) {
        policy.reset();
        await process.run();
      }
      if (await policy.shouldRetry) {
        await start();
      }
      _isRuning = false;
    }
  }
}
