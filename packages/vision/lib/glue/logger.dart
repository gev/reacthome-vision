import 'package:glue/ast.dart';
import 'package:glue/serialize.dart';

abstract final class LogTag {
  static const info = "info";
  static const debug = "debug";
  static const warning = "warning";
  static const error = "error";
}

class Logger {
  final Sink<String> _sink;

  Logger({required this._sink});

  void info<M>(M message) => log(message, tag: LogTag.info);
  void debug<M>(M message) => log(message, tag: LogTag.debug);
  void warning<M>(M message) => log(message, tag: LogTag.warning);
  void error<M>(M message) => log(message, tag: LogTag.error);

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
