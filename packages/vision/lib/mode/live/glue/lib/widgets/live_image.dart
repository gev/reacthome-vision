import 'dart:async';
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:glue/ir.dart';
import 'package:glue_flutter/glue_flutter.dart';
import 'package:vision/persistent/assets.dart';

/// Image widget function
/// Creates Flutter Image from Assets
Ir liveImage(Assets assets) {
  ImageProvider assetsImage(String src) => AssetsImage(src, assets);

  return IrNativeFunc(imageImpl(assetsImage));
}

class AssetsImage extends ImageProvider<AssetsImage> {
  final String _src;
  final Assets _assets;
  final double _scale;

  AssetsImage(this._src, this._assets, [this._scale = 1.0]);

  @override
  Future<AssetsImage> obtainKey(ImageConfiguration configuration) {
    return SynchronousFuture(this);
  }

  @override
  ImageStreamCompleter loadImage(AssetsImage key, ImageDecoderCallback decode) {
    return MultiFrameImageStreamCompleter(
      codec: _loadAsync(key, decode),
      scale: _scale,
      informationCollector: () => [
        DiagnosticsProperty('Image provider', this),
        DiagnosticsProperty('Image key', key),
      ],
    );
  }

  Future<Codec> _loadAsync(AssetsImage key, ImageDecoderCallback decode) async {
    final assetPath = await _assets.lookup(_src);
    final buffer = await ImmutableBuffer.fromFilePath(assetPath);
    return await decode(buffer);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is AssetsImage &&
        _src == other._src &&
        _assets == other._assets;
  }

  @override
  int get hashCode => Object.hash(_src, _assets);

  @override
  String toString() => '${objectRuntimeType(this, 'AssetsImage')}("$_src")';
}
