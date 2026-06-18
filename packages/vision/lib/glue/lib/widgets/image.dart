import 'dart:async';
import 'dart:io';
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:glue/ir.dart';
import 'package:glue_flutter/glue_flutter.dart';
import 'package:vision/persistent/assets.dart';

/// Image widget function
/// Creates Flutter Image from Assets
Ir image(Assets assets) {
  ImageProvider assetsImage(String src) => AssetsImage(src, assets);

  return IrNativeFunc(imageImpl(assetsImage));
}

class AssetsImage extends ImageProvider<AssetsImage> {
  final String _src;
  final Assets _assets;

  AssetsImage(this._src, this._assets);

  @override
  Future<AssetsImage> obtainKey(ImageConfiguration configuration) {
    return SynchronousFuture<AssetsImage>(this);
  }

  @override
  ImageStreamCompleter loadImage(AssetsImage key, ImageDecoderCallback decode) {
    return MultiFrameImageStreamCompleter(
      codec: _loadAsync(key, decode),
      scale: 1.0,
      informationCollector: () => <DiagnosticsNode>[
        DiagnosticsProperty<ImageProvider>('Image provider', this),
        DiagnosticsProperty<AssetsImage>('Image key', key),
      ],
    );
  }

  Future<Codec> _loadAsync(AssetsImage key, ImageDecoderCallback decode) async {
    final ValueNotifier<String?> reactiveAsset = _assets.lookup(_src);
    String? assetPath = reactiveAsset.value;

    if (assetPath == null) {
      final Completer<String> pathCompleter = Completer<String>();

      void listener() {
        final String? path = reactiveAsset.value;
        if (path != null && !pathCompleter.isCompleted) {
          pathCompleter.complete(path);
        }
      }

      reactiveAsset.addListener(listener);
      assetPath = await pathCompleter.future;
      reactiveAsset.removeListener(listener);
    }

    final File file = File(assetPath);
    final Uint8List bytes = await file.readAsBytes();

    if (bytes.lengthInBytes == 0) {
      throw StateError('AssetsImage failed to load an empty file: $assetPath');
    }

    final ImmutableBuffer buffer = await ImmutableBuffer.fromUint8List(bytes);

    return decode(buffer);
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
