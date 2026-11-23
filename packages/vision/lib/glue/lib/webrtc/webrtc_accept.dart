import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:glue/error.dart';
import 'package:glue/eval.dart';
import 'package:glue/ir.dart';
import 'package:vision/glue/lib/webrtc/webrtc_answer.dart';
import 'package:vision/widgets/media/webrtc/webrtc_player_pool.dart';

/// Accepts a JSEP offer for an acquired WebRTC session.
/// Usage: (webrtc-accept session-id {:sdp "..." :type "offer"})
final Ir webRtcAccept = IrNativeFunc(
  (Ir sessionIdIr) => Eval.pure(
    IrNativeFunc((Ir jsepIr) {
      final sessionId = switch (sessionIdIr) {
        IrString(:final value) => value,
        _ => null,
      };
      if (sessionId == null) {
        return throwError(
          wrongArgumentType(['`webrtc-accept` requires a string session ID']),
        );
      }

      final jsep = _jsepDescription(jsepIr);
      if (jsep == null) {
        return throwError(
          wrongArgumentType([
            '`webrtc-accept` requires a JSEP object with string `sdp` and `type`',
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

      return Eval.pure(
        IrNativeValue(
          Value(player.acceptOffer(jsep).then(toGlueWebRtcAnswer)),
        ),
      );
    }),
  ),
);

RTCSessionDescription? _jsepDescription(Ir ir) {
  if (ir case IrObject(:final properties)) {
    final sdp = properties['sdp'];
    final type = properties['type'];
    if (sdp is IrString && type is IrString) {
      return RTCSessionDescription(sdp.value, type.value);
    }
  }
  return null;
}
