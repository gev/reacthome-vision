import 'dart:convert';
import 'dart:typed_data';

import 'package:vision/logger.dart';
import 'package:vision/persistent/assets.dart';

class AssetsController {
  final Assets _assets;
  final Logger _log;

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
      _assets.writeChunk(
        name: name,
        size: assetSize,
        chunk: (offset: offset, buffer: chunkBuffer),
      );
    } catch (error) {
      _log.error(error);
    }
  }
}
