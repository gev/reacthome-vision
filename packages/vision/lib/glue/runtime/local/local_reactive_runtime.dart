import 'package:glue/runtime.dart';
import 'package:vision/glue/discovery_store.dart';
import 'package:vision/glue/runtime/local/local_env.dart';
import 'package:vision/glue/runtime/local/local_storage.dart';
import 'package:vision/glue/runtime/reactive_runtime.dart';

abstract class LocalReactiveRuntime extends ReactiveRuntime {
  late final Runtime _runtime;

  LocalReactiveRuntime({
    required LocalStorage storage,
    required DiscoveryStore discoveryStore,
    required super.log,
  }) {
    _runtime = Runtime.initial(
      makeLocalEnv(
        runtime: this,
        storage: storage,
        discoveryStore: discoveryStore,
        log: log,
      ),
    );
  }

  @override
  Runtime get runtime => _runtime;
}
