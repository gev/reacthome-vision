import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:vision/glue/stores/local_persistent_store.dart';
import 'package:vision/logger.dart';

class LocalStorage {
  late final LocalPersistentStore localPersistentStore;

  LocalStorage({required Directory path, required Logger log}) {
    final glueDbDirectory = Directory(p.join(path.path, 'db'))
      ..createSync(recursive: true);
    localPersistentStore = LocalPersistentStore(glueDbDirectory, log);
  }

  void dispose() {
    localPersistentStore.dispose();
  }
}
