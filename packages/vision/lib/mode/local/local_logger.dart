import 'package:flutter/foundation.dart';
import 'package:vision/logger.dart';

class LocalLogger extends Logger {
  @override
  void log<M>(M message, {required String tag}) {
    if (kDebugMode) {
      debugPrint('[$tag]: ${message.toString()}');
    }
  }
}
