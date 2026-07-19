import 'package:flutter/widgets.dart';
import 'package:glue/runtime.dart';

abstract class ReactiveRuntime extends ChangeNotifier {
  Runtime get runtime;
}
