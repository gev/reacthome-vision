abstract final class LogTag {
  static const info = "info";
  static const debug = "debug";
  static const warning = "warning";
  static const error = "error";
}

abstract class Logger {
  void info<M>(M message) => log(message, tag: LogTag.info);
  void debug<M>(M message) => log(message, tag: LogTag.debug);
  void warning<M>(M message) => log(message, tag: LogTag.warning);
  void error<M>(M message) => log(message, tag: LogTag.error);

  void log<M>(M message, {required String tag});
}
