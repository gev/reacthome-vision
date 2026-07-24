import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:vision/glue/persistent/glue_db.dart';
import 'package:vision/logger.dart';

class LocalStorage {
  late final GlueDb? localGlueDb;

  LocalStorage({required Directory path, required Logger log}) {
    final glueDbDirectory = Directory(p.join(path.path, 'db'))
      ..createSync(recursive: true);
    localGlueDb = makeGlueDb('local', glueDbDirectory, log);
  }

  void dispose() {
    localGlueDb?.dispose();
  }
}
