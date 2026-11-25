import 'package:flutter/foundation.dart';
import 'package:vision/util/logger.dart';

class LocalLogger extends Logger {
  @override
  void log<M>(M message, {required String tag}) {
    if (kDebugMode) {
      debugPrint('[$tag]: ${message.toString()}');
    }
  }
}
