import 'package:glue/ir.dart';
import 'package:vision/glue/pub_sub/glue_tracker.dart';
import 'package:vision/pub_sub/subscriber.dart';

typedef GlueSubscriber = Subscriber<IrDottedSymbol, Ir, GlueTracker>;
