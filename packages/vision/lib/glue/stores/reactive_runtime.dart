import 'package:flutter/material.dart';
import 'package:glue/ir.dart';
import 'package:glue/runtime.dart';
import 'package:vision/stores/put.dart';

typedef RuntimeBuilder = Runtime Function();
typedef ReactiveModule = ({Ir exports, Ir body});

class ReactiveRuntime implements Put<IrDottedSymbol, ReactiveModule> {
  late final ValueNotifier<RuntimeBuilder> _runtime;

  Runtime get runtime => _runtime.value();

  ReactiveRuntime({required RuntimeBuilder runtimeBuilder}) {
    _runtime = ValueNotifier(runtimeBuilder);
  }

  @override
  void put(IrDottedSymbol key, ReactiveModule module) {
    print(key);
    print(module);
  }
}
