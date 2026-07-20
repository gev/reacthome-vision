import 'dart:developer' as d;

import 'package:vision/logger.dart';

class LocalLogger extends Logger {
  @override
  void log<M>(M message, {required String tag}) {
    d.log('[$tag]: ${message.toString()}');
  }
}
