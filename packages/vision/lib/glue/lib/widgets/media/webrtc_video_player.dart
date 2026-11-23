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
  final sessionId = props.getString('session-id');
  if (sessionId == null) {
    return throwError(
      wrongArgumentType(['Property `session-id` required for WebRTC player']),
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
      sessionId: sessionId,
      width: props.width,
      height: props.height,
      fit: props.getValue<BoxFit>('fit') ?? BoxFit.contain,
      iceServers: _iceServers(props),
      onStart: onStart,
      onPlay: props.getVoidCallback('on-play')?.call(runtime),
      onPause: props.getVoidCallback('on-pause')?.call(runtime),
      onStop: props.getVoidCallback('on-stop')?.call(runtime),
    );

    return Eval.pure(IrNativeValue(Value(widget)));
  });
}

List<Map<String, dynamic>> _iceServers(WidgetProperties props) {
  final value = props.get('ice-servers');
  if (value case IrList(:final elements)) {
    return [
      for (final element in elements.unlock)
        if (_iceServer(element) case final server?) server,
    ];
  }
  return [];
}

Map<String, dynamic>? _iceServer(Ir value) {
  if (value case IrObject(:final properties)) {
    final server = <String, dynamic>{};
    for (final entry in properties.unlock.entries) {
      final fieldValue = _iceServerValue(entry.value);
      if (fieldValue != null) server[entry.key] = fieldValue;
    }
    if (server['urls'] != null) return server;
  }
  return null;
}

dynamic _iceServerValue(Ir value) => switch (value) {
  IrString(:final value) => value,
  IrInteger(:final value) => value,
  IrFloat(:final value) => value,
  IrBool(:final value) => value,
  IrList(:final elements) => [
    for (final element in elements.unlock)
      if (_iceServerValue(element) case final item?) item,
  ],
  _ => null,
};
