import 'package:glue/module.dart';
import 'package:vision/glue/lib/navigation/can_pop.dart';
import 'package:vision/glue/lib/navigation/navigator.dart';
import 'package:vision/glue/lib/navigation/pop.dart';
import 'package:vision/glue/lib/navigation/pop_until.dart';
import 'package:vision/glue/lib/navigation/push.dart';
import 'package:vision/glue/lib/navigation/push_replacement.dart';

/// Navigation module providing navigation functions
final navigationModule = nativeModule('ffi.vision.navigation', [
  ('push', push(false)),
  ('push-root', push(true)),
  ('push-replacement', pushReplacement(false)),
  ('push-replacement-root', pushReplacement(true)),
  ('pop', pop(false)),
  ('pop-root', pop(true)),
  ('pop-until', popUntil(false)),
  ('pop-until-root', popUntil(true)),
  ('can-pop?', canPop(false)),
  ('can-pop-root?', canPop(true)),
  ('navigator', navigator),
]);
