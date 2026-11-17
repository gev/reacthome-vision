import 'dart:convert';
import 'dart:typed_data';

import 'package:glue/ast.dart';
import 'package:glue/serialize.dart';
import 'package:vision/logger.dart';

class LiveLogger extends Logger {
  final Sink<Uint8List> _sink;

  LiveLogger({required this._sink});

  @override
  void log<M>(M message, {required String tag}) {
    _sink.add(
      utf8.encode(
        serializeAst(
          ListAst([
            _log,
            ObjectAst({
              "tag": StringAst(tag),
              "message": StringAst(message.toString()),
            }),
          ]),
        ),
      ),
    );
  }

  static const _log = SymbolAst('log');
}
