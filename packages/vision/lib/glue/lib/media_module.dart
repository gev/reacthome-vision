import 'package:glue/module.dart';
import 'package:vision/glue/lib/media/media_player.dart';

final ModuleInfo mediaModule = nativeModule('ffi.vision.media', [
  ('media-player', mediaPlayer),
]);
