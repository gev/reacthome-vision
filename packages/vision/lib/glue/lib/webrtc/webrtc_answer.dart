import 'package:glue/eval.dart';
import 'package:glue/ir.dart';
import 'package:vision/widgets/media/webrtc/webrtc_answer.dart';

Ir toGlueWebRtcAnswer(WebRtcAnswer answer) => IrNativeValue(
  Value(
    answer,
    getters: {
      'description': Eval.pure(IrString(answer.description.sdp ?? '')),
      'candidates': Eval.pure(IrNativeValue(Value(answer.candidates))),
    },
  ),
);
