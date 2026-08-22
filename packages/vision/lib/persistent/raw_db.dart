// raw_db.dart
import 'dart:async';
import 'dart:isolate';
import 'package:glue/either.dart';
import 'package:vision/persistent/db.dart';
import 'package:vision/persistent/db_command.dart';
import 'package:vision/persistent/raw_db_isolate.dart';
import 'package:vision/store/revision.dart';

class RawDb implements Db<String, String, int> {
  final Completer<SendPort> _sendPortCompleter = Completer<SendPort>();
  late final Isolate _isolate;
  final ReceivePort _receivePort = ReceivePort();

  final List<DbCommand> _pendingCommands = [];

  RawDb({required String path}) {
    _initIsolate(path);
  }

  Future<void> _initIsolate(String path) async {
    _isolate = await Isolate.spawn(rawDbIsolate, (
      path: path,
      port: _receivePort.sendPort,
    ));

    _receivePort.listen((message) {
      if (!_sendPortCompleter.isCompleted) {
        // Первое сообщение от изолята — это его SendPort
        final sendPort = message as SendPort;
        _sendPortCompleter.complete(sendPort);
        _receivePort.close();

        for (final cmd in _pendingCommands) {
          sendPort.send(cmd);
        }
        _pendingCommands.clear();
      }
    });
  }

  Future<void> _sendOrQueue(DbCommand command) async {
    if (_sendPortCompleter.isCompleted) {
      final sendPort = await _sendPortCompleter.future;
      sendPort.send(command);
    } else {
      _pendingCommands.add(command);
    }
  }

  @override
  Future<Either<DbError, Revision<String, int>>> lookup(String key) async {
    final replyPort = ReceivePort();
    await _sendOrQueue(LookupCmd(key, replyPort.sendPort));
    final result = await replyPort.first;
    replyPort.close();
    return result as Either<DbError, Revision<String, int>>;
  }

  @override
  Future<DbError?> store(String key, Revision<String, int> value) async {
    final replyPort = ReceivePort();
    await _sendOrQueue(StoreCmd(key, value, replyPort.sendPort));
    final result = await replyPort.first;
    replyPort.close();
    return result as DbError?;
  }

  void dispose() {
    _sendOrQueue(DisposeCmd());
    _isolate.kill(priority: Isolate.immediate);
  }
}
