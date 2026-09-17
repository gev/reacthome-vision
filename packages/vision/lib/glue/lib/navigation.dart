import 'package:glue/module.dart';
import 'package:vision/glue/lib/navigation/can_pop.dart';
import 'package:vision/glue/lib/navigation/navigator.dart';
import 'package:vision/glue/lib/navigation/pop.dart';
import 'package:vision/glue/lib/navigation/pop_until.dart';
import 'package:vision/glue/lib/navigation/push.dart';
import 'package:vision/glue/lib/navigation/push_replacement.dart';

/// Navigation module providing navigation functions
final navigationModule = nativeModule('ffi.vision.navigation', [
  ('push', push),
  ('push-replacement', pushReplacement),
  ('pop', pop),
  ('pop-until', popUntil),
  ('can-pop', canPop),
  ('navigator', navigator),
]);
