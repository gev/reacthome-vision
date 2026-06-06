import 'package:glue/ir.dart';
import 'package:vision/glue/stores/reactive_runtime.dart';
import 'package:vision/pub_sub/multi_store_subscriber.dart';
import 'package:vision/pub_sub/single_store_subscriber.dart';

typedef GlueSubscriber = MultiStoreSubscriber<IrDottedSymbol, Ir>;
typedef ModuleSubscriber =
    SingleStoreSubscriber<IrDottedSymbol, ReactiveModule>;
