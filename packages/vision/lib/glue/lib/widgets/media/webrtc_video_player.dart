import 'package:glue/error.dart';
import 'package:glue/eval.dart';
import 'package:glue/ir.dart';
import 'package:glue_flutter_ui/utils/widget_properties.dart';
import 'package:material_ui/material_ui.dart';
import 'package:vision/widgets/media/webrtc/webrtc_video_player.dart';

Ir webRtcVideoPlayer = IrNativeFunc(
  (Ir props) => _createWebRtcVideoPlayer(WidgetProperties(props)),
);

Eval<Ir> _createWebRtcVideoPlayer(WidgetProperties props) {
  final streamId = props.getString('stream-id');
  if (streamId == null) {
    return throwError(
      wrongArgumentType(['Property `stream-id` required for WebRTC player']),
    );
  }

  return getRuntime().bind((runtime) {
    final onStart = props.getVoidCallback('on-start')?.call(runtime);
    if (onStart == null) {
      return throwError(
        wrongArgumentType(['Property `on-start` required for WebRTC player']),
      );
    }

    final widget = WebRtcVideoPlayer(
      key: props.key,
      streamId: streamId,
      width: props.width,
      height: props.height,
      fit: props.getValue<BoxFit>('fit') ?? BoxFit.contain,
      onStart: onStart,
      onPlay: props.getVoidCallback('on-play')?.call(runtime),
      onPause: props.getVoidCallback('on-pause')?.call(runtime),
      onStop: props.getVoidCallback('on-stop')?.call(runtime),
    );

    return Eval.pure(IrNativeValue(Value(widget)));
  });
}
