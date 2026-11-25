import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:glue/error.dart';
import 'package:glue/eval.dart';
import 'package:glue/ir.dart';
import 'package:glue_flutter_ui/utils/widget_properties.dart';
import 'package:vision/glue/webrtc/glue_webrtc_player_pool.dart';

/// Adds a remote ICE candidate to an acquired WebRTC session.
/// Usage: (webrtc-add-candidate :session id :candidate candidate)
final Ir webRtcAddCandidate = IrNativeFunc(
  (Ir propsIr) => _addCandidate(WidgetProperties(propsIr)),
);

Eval<Ir> _addCandidate(WidgetProperties props) {
  final session = props.getString('session');
  if (session == null) {
    return throwError(
      wrongArgumentType(['`webrtc-add-candidate` requires a string `session`']),
    );
  }

  final candidate = _iceCandidate(props.get('candidate'));
  if (candidate == null) {
    return throwError(
      wrongArgumentType([
        '`webrtc-add-candidate` requires a candidate object with a string `candidate`',
      ]),
    );
  }

  final player = webRtcPlayerPool.getPlayer(session);
  if (player == null) {
    return throwError(
      RuntimeException(
        'not-found',
        IrString('No WebRTC player acquired for session "$session"'),
      ),
    );
  }

  player.addCandidate(candidate);
  return Eval.pure(IrVoid());
}

RTCIceCandidate? _iceCandidate(Ir? ir) {
  if (ir case IrObject(:final properties)) {
    final candidate = properties['candidate'];
    final sdpMid = properties['sdpMid'];
    final sdpMLineIndex = properties['sdpMLineIndex'];
    if (candidate is! IrString ||
        (sdpMid != null && sdpMid is! IrString && sdpMid is! IrVoid) ||
        (sdpMLineIndex != null &&
            sdpMLineIndex is! IrInteger &&
            sdpMLineIndex is! IrVoid)) {
      return null;
    }

    return RTCIceCandidate(
      candidate.value,
      sdpMid is IrString ? sdpMid.value : null,
      sdpMLineIndex is IrInteger ? sdpMLineIndex.value : null,
    );
  }
  return null;
}
