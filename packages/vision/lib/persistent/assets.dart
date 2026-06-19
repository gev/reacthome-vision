import 'dart:async';
import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:vision/persistent/asset_request.dart';

typedef Chunk = ({int offset, List<int> buffer});
typedef OnError = void Function(Object error);

class _AssetEntry {
  final Completer<String> completer;
  bool isDownloading = false;

  _AssetEntry([Completer<String>? completer])
    : completer = completer ?? Completer<String>();
}

class Assets {
  final Directory _path;
  final Directory _tmp;
  final AssetRequest _request;

  final Map<String, _AssetEntry> _cache = {};

  Assets({required this._path, required this._tmp, required this._request}) {
    _path.createSync(recursive: true);
    _tmp.deleteSync(recursive: true);
    _tmp.createSync(recursive: true);
  }

  Future<String> lookup(String name) {
    var entry = _cache[name];
    if (entry == null) {
      final assetPath = _assetFilePath(name);
      final assetFile = File(assetPath);
      if (assetFile.existsSync()) {
        entry = _AssetEntry(Completer()..complete(assetPath));
      } else {
        entry = _AssetEntry();
        _request.one(name);
      }
      _cache[name] = entry;
    }
    return entry.completer.future;
  }

  void reRequestAll() {
    final spec = <String>[];
    for (final entry in _cache.entries) {
      if (!entry.value.completer.isCompleted) {
        spec.add(entry.key);
        entry.value.isDownloading = false;
      }
    }
    _request.many(spec);
  }

  void start({
    required String name,
    required int size,
    required Stream<Chunk> source,
    required OnError onError,
  }) async {
    final entry = _cache[name];
    if (entry == null || entry.isDownloading || entry.completer.isCompleted) {
      return;
    }

    entry.isDownloading = true;

    final assetPath = _assetFilePath(name);
    final tmpFile = File(_tmpFilePath(name));

    try {
      var receivedBytes = 0;
      final accessFile = await tmpFile.open(mode: FileMode.writeOnly);

      try {
        await accessFile.truncate(size);
        final receivedChuncks = <int>{};
        await for (final chunk in source) {
          if (receivedChuncks.contains(chunk.offset)) continue;
          if (!entry.isDownloading) break;
          await accessFile.setPosition(chunk.offset);
          await accessFile.writeFrom(chunk.buffer);
          receivedChuncks.add(chunk.offset);
          receivedBytes += chunk.buffer.length;
        }
      } finally {
        await accessFile.close();
      }

      if (receivedBytes != size) {
        throw StateError(
          'Stream closed prematurely: received $receivedBytes out of $size bytes.',
        );
      }

      await tmpFile.rename(assetPath);
      entry.completer.complete(assetPath);
    } catch (error) {
      try {
        await tmpFile.delete();
      } finally {
        onError(error);
      }
    } finally {
      entry.isDownloading = false;
    }
  }

  String _tmpFilePath(String name) => p.join(_tmp.path, name);

  String _assetFilePath(String name) => p.join(_path.path, name);
}
