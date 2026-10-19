import 'package:flutter/cupertino.dart';
import 'package:glue/error.dart';
import 'package:glue/eval.dart';
import 'package:glue/ir.dart';
import 'package:glue_flutter/glue_flutter.dart';
import 'package:vision/widgets/media/video_player.dart';

Ir videoPlayer = IrNativeFunc(
  (Ir props) => _createVideoPlayer(WidgetProperties(props)),
);

Eval<Ir> _createVideoPlayer(WidgetProperties props) {
  final url = props.getString('url');
  if (url == null) {
    return throwError(
      wrongArgumentType(['Property `url` required for media player']),
    );
  }

  return getRuntime().map((runtime) {
    final widget = VideoPlayer(
      key: props.key,
      url: url,
      width: props.width,
      height: props.height,
      fit: props.getValue<BoxFit>('fit') ?? BoxFit.contain,
    );

    return IrNativeValue(Value(widget));
  });
}
