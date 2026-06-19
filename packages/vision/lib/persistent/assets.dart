import 'dart:async';
import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:vision/glue/logger.dart';
import 'package:vision/persistent/asset_request.dart';

typedef Chunk = ({int offset, List<int> buffer});

class Assets {
  final Directory _path;
  final Directory _tmp;
  final AssetRequest _request;
  final Logger _log;

  final Map<String, Completer<String>> _completers = {};
  final Map<String, StreamController<Chunk>> _controllers = {};

  Assets({
    required this._path,
    required this._tmp,
    required this._request,
    required this._log,
  }) {
    _path.createSync(recursive: true);
    _tmp.deleteSync(recursive: true);
    _tmp.createSync(recursive: true);
  }

  Future<String> lookup(String name) {
    var comleter = _completers[name];
    if (comleter == null) {
      final assetPath = _assetFilePath(name);
      final assetFile = File(assetPath);
      if (assetFile.existsSync()) {
        comleter = Completer()..complete(assetPath);
      } else {
        comleter = Completer();
        _request.one(name);
      }
      _completers[name] = comleter;
    }
    return comleter.future;
  }

  void reRequestAll() {
    final spec = <String>[];
    for (final entry in _completers.entries) {
      if (!entry.value.isCompleted) {
        spec.add(entry.key);
      }
    }
    _request.many(spec);
  }

  void writeChunk({
    required String name,
    required int size,
    required Chunk chunk,
  }) async {
    final completer = _completers[name];
    if (completer == null || completer.isCompleted) return;
    var controller = _controllers[name];
    if (controller == null) {
      controller = StreamController();
      _controllers[name] = controller;
      _receiveChunks(name, size, completer, controller);
    }
    controller.add(chunk);
  }

  void _receiveChunks(
    String name,
    int size,
    Completer<String> completer,
    StreamController<Chunk> controller,
  ) async {
    final assetPath = _assetFilePath(name);
    final tmpFile = File(_tmpFilePath(name));

    try {
      final accessFile = await tmpFile.open(mode: FileMode.writeOnly);

      try {
        await accessFile.truncate(size);

        final stream = controller.stream.timeout(
          const Duration(seconds: 15),
          onTimeout: (sink) {
            sink.addError(TimeoutException('Asset download timed out: $name'));
          },
        );

        var receivedBytes = 0;
        final receivedChuncks = <int>{};
        await for (final chunk in stream) {
          if (receivedChuncks.contains(chunk.offset)) continue;
          await accessFile.setPosition(chunk.offset);
          await accessFile.writeFrom(chunk.buffer);
          receivedChuncks.add(chunk.offset);
          receivedBytes += chunk.buffer.length;
          if (receivedBytes == size) {
            await tmpFile.rename(assetPath);
            completer.complete(assetPath);
          }
        }
      } finally {
        await accessFile.close();
      }
    } catch (error) {
      try {
        await tmpFile.delete();
      } finally {
        _log.error(error);
      }
    } finally {
      _controllers.remove(name);
      controller.close();
    }
  }

  String _tmpFilePath(String name) => p.join(_tmp.path, name);

  String _assetFilePath(String name) => p.join(_path.path, name);
}
