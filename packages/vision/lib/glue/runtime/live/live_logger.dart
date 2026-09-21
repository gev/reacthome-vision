import 'package:glue/ast.dart';
import 'package:glue/serialize.dart';
import 'package:vision/logger.dart';

class LiveLogger extends Logger {
  final Sink<String> _sink;

  LiveLogger({required this._sink});

  @override
  void log<M>(M message, {required String tag}) {
    _sink.add(
      serializeAst(
        ListAst([
          _log,
          ObjectAst({
            "tag": StringAst(tag),
            "message": StringAst(message.toString()),
          }),
        ]),
      ),
    );
  }

  static const _log = SymbolAst('log');
}
