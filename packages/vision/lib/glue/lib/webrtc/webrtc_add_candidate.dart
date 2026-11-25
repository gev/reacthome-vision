import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:glue/error.dart';
import 'package:glue/eval.dart';
import 'package:glue/ir.dart';
import 'package:vision/glue/webrtc/glue_webrtc_player_pool.dart';

/// Adds a remote ICE candidate to an acquired WebRTC session.
/// Usage: (webrtc-add-candidate session-id (:candidate "..." :sdpMid "v" :sdpMLineIndex 0))
final Ir webRtcAddCandidate = IrNativeFunc(
  (Ir sessionIdIr) => Eval.pure(
    IrNativeFunc((Ir candidateIr) {
      final sessionId = switch (sessionIdIr) {
        IrString(:final value) => value,
        _ => null,
      };
      if (sessionId == null) {
        return throwError(
          wrongArgumentType([
            '`webrtc-add-candidate` requires a string session ID',
          ]),
        );
      }

      final candidate = _iceCandidate(candidateIr);
      if (candidate == null) {
        return throwError(
          wrongArgumentType([
            '`webrtc-add-candidate` requires a candidate object with a string `candidate`',
          ]),
        );
      }

      final player = webRtcPlayerPool.getPlayer(sessionId);
      if (player == null) {
        return throwError(
          RuntimeException(
            'not-found',
            IrString('No WebRTC player acquired for session "$sessionId"'),
          ),
        );
      }

      player.addCandidate(candidate);
      return Eval.pure(IrVoid());
    }),
  ),
);

RTCIceCandidate? _iceCandidate(Ir ir) {
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
