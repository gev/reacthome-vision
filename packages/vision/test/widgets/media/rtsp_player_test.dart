import 'dart:async';
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fvp/mdk.dart' as fvp;
import 'package:vision/widgets/media/player_pool.dart';
import 'package:vision/widgets/media/rtsp/rtsp_player.dart';

class FakeNativePlayer implements fvp.Player {
  final status =
      StreamController<
        ({fvp.MediaStatus oldValue, fvp.MediaStatus newValue})
      >.broadcast();
  final states =
      StreamController<
        ({fvp.PlaybackState oldValue, fvp.PlaybackState newValue})
      >.broadcast();
  final events = StreamController<fvp.MediaEvent>.broadcast();
  final prepared = Completer<int>();
  Completer<int>? textureResult;
  bool disposed = false;
  int textureCalls = 0;

  @override
  final textureId = ValueNotifier<int?>(null);
  @override
  fvp.PlaybackState state = fvp.PlaybackState.stopped;
  @override
  int position = 0;
  @override
  get onMediaStatus => status.stream;
  @override
  get onStateChanged => states.stream;
  @override
  get onEvent => events.stream;
  @override
  Future<Size?> get textureSize async => const Size(640, 480);
  @override
  Future<int> prepare({
    int position = 0,
    fvp.SeekFlag flags = const fvp.SeekFlag(fvp.SeekFlag.defaultFlags),
    Future<bool> Function()? callback,
    bool reply = false,
  }) => prepared.future;
  @override
  Future<int> updateTexture({
    int? width,
    int? height,
    bool? tunnel,
    bool? fit,
  }) async {
    textureCalls++;
    final id = await (textureResult?.future ?? Future.value(1));
    textureId.value = id;
    return id;
  }

  @override
  Future<void> disposeAsync() async {
    disposed = true;
    await status.close();
    await states.close();
    await events.close();
    textureId.dispose();
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => null;
}

void main() {
  late List<FakeNativePlayer> natives;
  late PlayerPool<String, RtspPlayer> pool;

  setUp(() {
    natives = [];
    pool = PlayerPool(
      createPlayer: (url) => RtspPlayer(
        url,
        createPlayer: () {
          final native = FakeNativePlayer();
          natives.add(native);
          return native;
        },
      ),
      disposeOnLastRelease: true,
    );
  });
  tearDown(() => pool.disposeAll());

  testWidgets('shared visibility controls allocation and final eviction', (
    tester,
  ) async {
    final first = pool.acquire('camera');
    final second = pool.acquire('camera');
    expect(first.player, same(second.player));
    expect(natives, isEmpty);
    first.play();
    second.play();
    await tester.pump();
    expect(natives, hasLength(1));
    natives.single.prepared.complete(0);
    await tester.pump();
    expect(first.player.isInitialized, isTrue);
    first.pause();
    await tester.pump();
    expect(natives.single.disposed, isFalse);
    second.pause();
    await tester.pump(const Duration(seconds: 29));
    expect(natives.single.state, fvp.PlaybackState.paused);
    expect(natives.single.disposed, isFalse);
    await tester.pump(const Duration(seconds: 1));
    expect(natives.single.disposed, isTrue);
    expect(first.player.textureId, isNull);
    first.play();
    await tester.pump();
    expect(natives, hasLength(2));
    first.release();
    second.release();
    await tester.pump();
    expect(natives.last.disposed, isTrue);
    expect(pool.getPlayer('camera'), isNull);
  });

  testWidgets('resume before timeout reuses player and resets idle countdown', (
    tester,
  ) async {
    final lease = pool.acquire('camera')..play();
    await tester.pump();
    natives.single.prepared.complete(0);
    await tester.pump();
    lease.pause();
    await tester.pump(const Duration(seconds: 25));
    lease.play();
    await tester.pump(const Duration(seconds: 10));
    expect(natives, hasLength(1));
    expect(natives.single.state, fvp.PlaybackState.playing);
    expect(natives.single.disposed, isFalse);
    lease.pause();
    await tester.pump(const Duration(seconds: 29));
    expect(natives.single.disposed, isFalse);
    await tester.pump(const Duration(seconds: 1));
    expect(natives.single.disposed, isTrue);
    lease.release();
  });

  testWidgets('shared timeout uses longest setting and supports updates', (
    tester,
  ) async {
    final first = pool.acquire('camera');
    final second = pool.acquire('camera');
    first.player.setLeaseTimeout(first, const Duration(seconds: 2));
    second.player.setLeaseTimeout(second, const Duration(seconds: 5));
    first.play();
    await tester.pump();
    natives.single.prepared.complete(0);
    await tester.pump();
    first.pause();
    await tester.pump(const Duration(seconds: 3));
    expect(natives.single.disposed, isFalse);
    second.player.setLeaseTimeout(second, const Duration(seconds: 1));
    await tester.pump(const Duration(seconds: 2));
    expect(natives.single.disposed, isTrue);
    first.release();
    second.release();
  });

  testWidgets('preparation completing during grace period remains paused', (
    tester,
  ) async {
    final lease = pool.acquire('camera')..play();
    await tester.pump();
    lease.pause();
    natives.single.prepared.complete(0);
    await tester.pump();
    expect(lease.player.isInitialized, isTrue);
    expect(natives.single.state, fvp.PlaybackState.paused);
    await tester.pump(const Duration(seconds: 21));
    expect(natives.single.disposed, isFalse);
    expect(lease.player.hasError, isFalse);
    lease.play();
    await tester.pump();
    expect(natives, hasLength(1));
    expect(natives.single.state, fvp.PlaybackState.playing);
    lease.release();
    await tester.pump();
  });

  testWidgets('failure retries and pause cancels retry', (tester) async {
    final lease = pool.acquire('camera')..play();
    await tester.pump();
    natives.single.prepared.complete(-1);
    await tester.pump();
    expect(lease.player.hasError, isTrue);
    expect(natives.single.disposed, isTrue);
    await tester.pump(const Duration(seconds: 1));
    expect(natives, hasLength(2));
    natives.last.prepared.complete(0);
    await tester.pump();
    expect(lease.player.isInitialized, isTrue);
    expect(lease.player.hasError, isFalse);
    natives.last.status.add((
      oldValue: const fvp.MediaStatus(fvp.MediaStatus.loaded),
      newValue: const fvp.MediaStatus(fvp.MediaStatus.invalid),
    ));
    await tester.pump();
    lease.pause();
    await tester.pump(const Duration(seconds: 30));
    expect(natives, hasLength(2));
  });

  testWidgets('late prepare cannot revive a hidden session', (tester) async {
    final lease = pool.acquire('camera')..play();
    await tester.pump();
    final old = natives.single;
    lease.pause();
    await tester.pump(const Duration(seconds: 30));
    lease.play();
    await tester.pump();
    old.prepared.complete(0);
    await tester.pump();
    expect(old.textureCalls, 0);
    expect(lease.player.isInitialized, isFalse);
    natives.last.prepared.complete(0);
    await tester.pump();
    expect(lease.player.isInitialized, isTrue);
    lease.release();
    await tester.pump();
  });

  testWidgets('texture creation completes before teardown and restart', (
    tester,
  ) async {
    final lease = pool.acquire('camera')..play();
    await tester.pump();
    final old = natives.single;
    old.textureResult = Completer<int>();
    old.prepared.complete(0);
    await tester.pump();
    lease.pause();
    await tester.pump(const Duration(seconds: 30));
    lease.play();
    await tester.pump();
    expect(old.disposed, isFalse);
    expect(natives, hasLength(1));
    old.textureResult!.complete(1);
    await tester.pump();
    expect(old.disposed, isTrue);
    expect(natives, hasLength(2));
    lease.release();
    await tester.pump();
  });

  testWidgets('hung preparation and stalled playback reconnect', (
    tester,
  ) async {
    final lease = pool.acquire('camera')..play();
    await tester.pump();
    await tester.pump(const Duration(seconds: 20));
    expect(lease.player.hasError, isTrue);
    await tester.pump(const Duration(seconds: 1));
    natives.last.prepared.complete(0);
    await tester.pump();
    expect(lease.player.isInitialized, isTrue);
    await tester.pump(const Duration(seconds: 20));
    expect(lease.player.hasError, isTrue);
    lease.release();
    await tester.pump(const Duration(seconds: 30));
    expect(natives, hasLength(2));
  });
}
