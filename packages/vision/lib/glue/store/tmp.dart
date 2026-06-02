import 'package:glue/ir.dart';
import 'package:vision/glue/pub_sub/glue_subscriber.dart';
import 'package:vision/stores/lookup.dart';
import 'package:vision/stores/reactive_cache.dart';
import 'package:vision/stores/subscribable.dart';

ReactiveLookup<String, Ir> tmp(GlueSubscriber subscriber) =>
    Subscribable(subscriber: subscriber, store: ReactiveCache());
