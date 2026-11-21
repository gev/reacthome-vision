import 'dart:ui' show Size;

import 'package:flutter/foundation.dart';

/// Common observable playback surface used by media widgets and player pools.
abstract class Player extends ChangeNotifier {
  bool get isInitialized;
  bool get hasError;
  int? get textureId;

  Size? get videoSize;

  void play();
  void pause();
}
