import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:glue/error.dart';
import 'package:glue/eval.dart';
import 'package:glue/ir.dart';
import 'package:glue_flutter_ui/utils/widget_properties.dart';
import 'package:vision/glue/webrtc/glue_webrtc_player_pool.dart';

/// Applies an offer to an acquired WebRTC session.
/// Usage: (webrtc-accept :session id :offer jsep :on-candidate callback)
final Ir webRtcAccept = IrNativeFunc(
  (Ir propsIr) => _acceptOffer(WidgetProperties(propsIr)),
);

Eval<Ir> _acceptOffer(WidgetProperties props) {
  final session = props.getString('session');
  if (session == null) {
    return throwError(
      wrongArgumentType(['`webrtc-accept` requires a string `session`']),
    );
  }

  final offer = _offerDescription(props.get('offer'));
  if (offer == null) {
    return throwError(
      wrongArgumentType([
        '`webrtc-accept` requires an `offer` object with string `sdp` and `type`',
      ]),
    );
  }

  final onCandidate = props.get('on-candidate');
  if (onCandidate != null && !isCallable(onCandidate)) {
    return throwError(
      wrongArgumentType(['Property `on-candidate` must be a function']),
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

  return getRuntime().bind((runtime) {
    final onCandidateCallback = onCandidate == null
        ? null
        : (Ir candidate) {
            runEval(apply(onCandidate, [candidate]), runtime);
          };

    return Eval.pure(
      IrNativeValue(
        Value(
          player.acceptOffer(offer, onCandidate: onCandidateCallback),
        ),
      ),
    );
  });
}

RTCSessionDescription? _offerDescription(Ir? ir) {
  if (ir case IrObject(:final properties)) {
    final sdp = properties['sdp'];
    final type = properties['type'];
    if (sdp is IrString && type is IrString) {
      return RTCSessionDescription(sdp.value, type.value);
    }
  }
  return null;
}
