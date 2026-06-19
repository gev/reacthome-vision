import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:vision/glue/logger.dart';
import 'package:vision/persistent/assets.dart';

class SinkEntry {
  final StreamController<Chunk> controller = StreamController();
}

class AssetsController {
  final Assets _assets;
  final Logger _log;

  final Map<String, SinkEntry> _sinks = {};

  AssetsController({required this._assets, required this._log});

  void acceptAsset(Uint8List body) {
    final data = ByteData.sublistView(body);

    final assetSize = data.getUint64(0, Endian.big);
    final chunkSize = data.getUint32(8, Endian.big);
    final offset = data.getUint64(12, Endian.big);

    final nameLength = body.length - 20 - chunkSize;
    final nameBytes = Uint8List.sublistView(body, 20, 20 + nameLength);

    try {
      final name = utf8.decode(nameBytes);
      final chunkBuffer = Uint8List.sublistView(body, 20 + nameLength);

      final chunk = (offset: offset, buffer: chunkBuffer);
      print('$name $assetSize $chunkSize ${chunk.offset} ');

      final sink = _sinks[name];
      if (sink != null) {
        sink.controller.add(chunk);
      } else {
        final newSink = SinkEntry();
        _assets.start(
          name: name,
          size: assetSize,
          source: newSink.controller.stream,
          onDone: () {
            newSink.controller.close();
            _sinks.remove(name);
          },
          onError: (error) {
            newSink.controller.close();
            _sinks.remove(name);
            _log.error(error);
          },
        );
        _sinks[name] = newSink;
        newSink.controller.add(chunk);
      }
    } catch (error) {
      _log.error(error);
    }
  }
}
