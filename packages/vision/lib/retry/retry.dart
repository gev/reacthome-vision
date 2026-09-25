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

  var _isRunning = false;

  Retry({required this.process, required this.policy});

  Future<void> start() async {
    if (!_isRunning) {
      _isRunning = true;
      if (await process.init()) {
        policy.reset();
        await process.run();
      }
      _isRunning = false;
      if (await policy.shouldRetry) {
        await start();
      }
    }
  }
}
