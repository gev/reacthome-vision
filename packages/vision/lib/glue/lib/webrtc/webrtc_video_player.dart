import 'package:glue/error.dart';
import 'package:glue/eval.dart';
import 'package:glue/ir.dart';
import 'package:glue_flutter_ui/utils/widget_properties.dart';
import 'package:material_ui/material_ui.dart';
import 'package:vision/glue/webrtc/glue_webrtc_player.dart';
import 'package:vision/glue/webrtc/glue_webrtc_player_pool.dart';
import 'package:vision/widgets/media/webrtc/webrtc_ice_server.dart';
import 'package:vision/widgets/media/webrtc/webrtc_ice_transport_policy.dart';
import 'package:vision/widgets/media/webrtc/webrtc_video_player.dart';

Ir webRtcVideoPlayer = IrNativeFunc(
  (Ir props) => _createWebRtcVideoPlayer(WidgetProperties(props)),
);

Eval<Ir> _createWebRtcVideoPlayer(WidgetProperties props) {
  final sessionId = props.getString('session-id');
  if (sessionId == null) {
    return throwError(
      wrongArgumentType(['Property `session-id` required for WebRTC player']),
    );
  }

  return getRuntime().bind((runtime) {
    final onStart = props.getVoidCallback('on-start')?.call(runtime);
    final widget = WebRtcVideoPlayer<GlueWebRtcPlayer>(
      key: props.key,
      playerPool: webRtcPlayerPool,
      sessionId: sessionId,
      width: props.width,
      height: props.height,
      fit: props.getValue<BoxFit>('fit') ?? BoxFit.contain,
      iceServers: props.getValues<WebRtcIceServer>('ice-servers'),
      iceTransportPolicy:
          props.getValue<WebRtcIceTransportPolicy>('ice-transport-policy') ??
          WebRtcIceTransportPolicy.all,
      onStart: onStart,
      onPlay: props.getVoidCallback('on-play')?.call(runtime),
      onPause: props.getVoidCallback('on-pause')?.call(runtime),
      onStop: props.getVoidCallback('on-stop')?.call(runtime),
    );

    return Eval.pure(IrNativeValue(Value(widget)));
  });
}
