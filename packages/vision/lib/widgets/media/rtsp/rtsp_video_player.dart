import 'package:material_ui/material_ui.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'package:vision/widgets/media/rtsp/rtsp_player.dart';
import 'package:vision/widgets/media/rtsp/rtsp_player_pool.dart';

/// Displays a pooled RTSP stream through a unique playback lease.
///
/// Visibility, app lifecycle, and [TickerMode] jointly determine whether this
/// widget requests playback. Its timeout applies while every shared view is
/// paused.
class RtspVideoPlayer extends StatefulWidget {
  final String url;
  final double? width;
  final double? height;
  final BoxFit fit;

  /// Time to retain paused resources after all views become hidden.
  /// Views sharing a URL use the longest configured timeout.
  final Duration timeout;

  const RtspVideoPlayer({
    super.key,
    required this.url,
    this.width,
    this.height,
    required this.fit,
    this.timeout = const Duration(seconds: 30),
  });

  @override
  State<RtspVideoPlayer> createState() => _RtspVideoPlayerState();
}

class _RtspVideoPlayerState extends State<RtspVideoPlayer>
    with WidgetsBindingObserver {
  final Key _visibilityKey = UniqueKey();
  late RtspPlayerLease _lease;
  RtspPlayer get _player => _lease.player;
  bool _isVisible = false;
  bool _tickerEnabled = true;
  bool _appActive = true;

  void _syncPlayback() {
    if (_isVisible && _tickerEnabled && _appActive) {
      _lease.play();
    } else {
      _lease.pause();
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _tickerEnabled = TickerMode.valuesOf(context).enabled;
    // A shared player may notify widgets outside this build subtree.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) _syncPlayback();
    });
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    _appActive = state == AppLifecycleState.resumed;
    _syncPlayback();
  }

  @override
  void initState() {
    super.initState();
    _lease = RtspPlayerPool.instance.acquire(widget.url);
    _player.setLeaseTimeout(_lease, widget.timeout);
    WidgetsBinding.instance.addObserver(this);
    final state = WidgetsBinding.instance.lifecycleState;
    _appActive = state == null || state == AppLifecycleState.resumed;
  }

  @override
  void didUpdateWidget(RtspVideoPlayer oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.url != widget.url) {
      _player.removeLeaseTimeout(_lease);
      _lease.release();
      _lease = RtspPlayerPool.instance.acquire(widget.url);
      _player.setLeaseTimeout(_lease, widget.timeout);
      _syncPlayback();
    } else if (oldWidget.timeout != widget.timeout) {
      _player.setLeaseTimeout(_lease, widget.timeout);
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _player.removeLeaseTimeout(_lease);
    _lease.release();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: _visibilityKey,
      onVisibilityChanged: (info) {
        if (!mounted) return;
        _isVisible = info.visibleFraction > 0;
        _syncPlayback();
      },
      child: SizedBox(
        width: widget.width,
        height: widget.height,
        child: AnimatedBuilder(
          animation: _player,
          builder: (context, _) {
            final videoSize = _player.videoSize;
            final textureId = _player.textureId;
            if (_player.hasError) {
              return const Center(child: Icon(Icons.videocam_off_outlined));
            }
            if (!_player.isInitialized ||
                videoSize == null ||
                textureId == null) {
              return const Center(child: CircularProgressIndicator());
            }

            return ClipRect(
              child: FittedBox(
                fit: widget.fit,
                child: SizedBox(
                  width: videoSize.width,
                  height: videoSize.height,
                  child: Texture(textureId: textureId),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
