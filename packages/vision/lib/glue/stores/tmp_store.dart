import 'package:vision/glue/pub_sub/glue_subscriber.dart';
import 'package:vision/glue/stores/glue_reactive_cache.dart';
import 'package:vision/glue/stores/glue_subscribable.dart';
import 'package:vision/stores/subscribable.dart';

GlueSubscribable tmpStore(GlueSubscriber subscriber) {
  final store = GlueReactiveCache();
  return ReactiveSubscribable(
    subscriber: subscriber,
    lookupStore: store,
    versionStore: store,
    putStore: store,
  );
}
