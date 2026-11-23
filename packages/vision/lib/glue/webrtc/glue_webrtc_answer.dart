import 'package:glue/ir.dart';
import 'package:vision/widgets/media/webrtc/webrtc_answer.dart';

typedef GlueWebRtcAnswer = WebRtcAnswer<Ir>;

IrObject glueWebRtcAnswerToIr(GlueWebRtcAnswer answer) => IrObject({
  'description': answer.description,
  'candidates': IrNativeValue(Value(answer.candidates)),
});
