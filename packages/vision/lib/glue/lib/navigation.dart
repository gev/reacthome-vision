import 'package:glue/module.dart';
import 'package:vision/glue/lib/navigation/can-pop.dart';
import 'package:vision/glue/lib/navigation/pop-until.dart';
import 'package:vision/glue/lib/navigation/pop.dart';
import 'package:vision/glue/lib/navigation/push-replacement.dart';
import 'package:vision/glue/lib/navigation/push.dart';
import 'package:vision/glue/lib/navigation/route.dart';
import 'package:vision/glue/lib/navigation/routes.dart';

/// Navigation module providing navigation functions
final navigationModule = nativeModule('ffi.vision.navigation', [
  ('route', route),
  ('routes', routes),
  ('push', push),
  ('push-replacement', pushReplacement),
  ('pop', pop),
  ('pop-until', popUntil),
  ('can-pop', canPop),
]);
