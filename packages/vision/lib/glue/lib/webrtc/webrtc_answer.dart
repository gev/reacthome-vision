import 'package:flutter/foundation.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:glue/ir.dart';
import 'package:vision/widgets/media/webrtc/webrtc_answer.dart';

IrObject toGlueWebRtcAnswer(WebRtcAnswer answer) {
  final candidates = ValueNotifier<Ir>(
    _toGlueCandidates(answer.candidates.value),
  );
  answer.candidates.addListener(() {
    candidates.value = _toGlueCandidates(answer.candidates.value);
  });

  return IrObject({
    'description': IrObject({
      'sdp': toIr(answer.description.sdp),
      'type': toIr(answer.description.type),
    }),
    'candidates': IrNativeValue(Value(candidates)),
  });
}

IrList _toGlueCandidates(List<RTCIceCandidate> candidates) => IrList(
  candidates.map((candidate) {
    return IrObject({
      'candidate': toIr(candidate.candidate),
      'sdpMid': toIr(candidate.sdpMid),
      'sdpMLineIndex': toIr(candidate.sdpMLineIndex),
    });
  }).toList(),
);
