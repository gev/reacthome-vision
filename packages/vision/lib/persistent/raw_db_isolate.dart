// raw_db_worker_entry.dart (или в файле воркера)
import 'dart:isolate';
import 'db_command.dart';
import 'raw_db_woker.dart';

typedef RawDbIsolate = ({String path, SendPort port});

void rawDbIsolate(RawDbIsolate initData) {
  final db = RawDbWorker(path: initData.path);
  final port = ReceivePort();

  initData.port.send(port.sendPort);

  port.listen((message) {
    switch (message) {
      case LookupCmd(:final key, :final replyTo):
        replyTo.send(db.lookup(key));

      case StoreCmd(:final key, :final value, :final replyTo):
        replyTo.send(db.store(key, value));

      case DisposeCmd():
        db.dispose();
        port.close();
        Isolate.exit();
    }
  });
}
