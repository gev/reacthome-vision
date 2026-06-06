import 'package:glue/ir.dart';
import 'package:glue/module.dart';
import 'package:vision/pub_sub/multi_store_subscriber.dart';
import 'package:vision/pub_sub/single_store_subscriber.dart';

typedef GlueSubscriber = MultiStoreSubscriber<String, Ir>;
typedef ModuleSubscriber = SingleStoreSubscriber<String, RegisteredModule>;
