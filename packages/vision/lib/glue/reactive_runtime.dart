import 'package:flutter/widgets.dart';
import 'package:glue/ir.dart';
import 'package:glue/runtime.dart';
import 'package:vision/store/put.dart';
import 'package:vision/store/revision.dart';
import 'package:vision/store/version.dart';

abstract class ReactiveRuntime extends ChangeNotifier
    implements Version<String, int>, Put<String, Revision<Ir, int>> {
  Runtime get runtime;
  void loadModule(String name);
}
