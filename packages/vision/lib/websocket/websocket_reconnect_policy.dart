/// A reconnection policy that implements exponential backoff strategy.
///
/// This policy increases the delay between reconnection attempts exponentially,
/// which helps to avoid overwhelming the server while still providing timely
/// reconnection for temporary failures.
class WebSocketReconnectPolicy {
  /// The initial delay in milliseconds before the first reconnection attempt.
  final int initialDelayMs;

  /// The maximum delay in milliseconds between reconnection attempts.
  final int maxDelayMs;

  /// The multiplier applied to the delay after each failed attempt.
  final double multiplier;

  /// The maximum number of reconnection attempts. Set to null for unlimited.
  final int? maxAttempts;

  int _currentDelayMs;
  int _attemptCount = 0;

  WebSocketReconnectPolicy({
    this.initialDelayMs = 1000,
    this.maxDelayMs = 30000,
    this.multiplier = 2.0,
    this.maxAttempts,
  }) : _currentDelayMs = initialDelayMs;

  /// Returns true if more reconnection attempts are allowed.
  bool get canRetry {
    if (maxAttempts == null) return true;
    return _attemptCount < maxAttempts!;
  }

  /// Returns the delay in milliseconds before the next reconnection attempt.
  int get nextDelayMs {
    final delay = _currentDelayMs;
    _currentDelayMs = (_currentDelayMs * multiplier)
        .clamp(initialDelayMs.toDouble(), maxDelayMs.toDouble())
        .toInt();
    return delay;
  }

  /// Resets the policy to its initial state.
  void reset() {
    _currentDelayMs = initialDelayMs;
    _attemptCount = 0;
  }

  /// Records a failed reconnection attempt.
  void recordFailedAttempt() {
    _attemptCount++;
  }

  /// Records a successful connection, resetting the policy.
  void recordSuccess() {
    reset();
  }

  /// Creates a copy of this policy with optional parameter overrides.
  WebSocketReconnectPolicy copyWith({
    int? initialDelayMs,
    int? maxDelayMs,
    double? multiplier,
    int? maxAttempts,
  }) {
    return WebSocketReconnectPolicy(
      initialDelayMs: initialDelayMs ?? this.initialDelayMs,
      maxDelayMs: maxDelayMs ?? this.maxDelayMs,
      multiplier: multiplier ?? this.multiplier,
      maxAttempts: maxAttempts ?? this.maxAttempts,
    );
  }
}
