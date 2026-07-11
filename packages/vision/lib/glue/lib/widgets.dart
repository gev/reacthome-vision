import 'package:glue/module.dart';
import 'package:vision/glue/lib/widgets/app.dart';
import 'package:vision/glue/lib/widgets/canvas.dart';
import 'package:vision/glue/lib/widgets/image.dart';
import 'package:vision/glue/lib/widgets/media_query.dart';
import 'package:vision/glue/lib/widgets/placeholder.dart';
import 'package:vision/glue/lib/widgets/screen.dart';
import 'package:vision/glue/lib/widgets/slider/circular_slider.dart';
import 'package:vision/glue/lib/widgets/slider/horizontal_slider.dart';
import 'package:vision/glue/lib/widgets/slider/vertical_slider.dart';
import 'package:vision/glue/lib/widgets/theme.dart';
import 'package:vision/persistent/assets.dart';

ModuleInfo widgetsModule(Assets assets) {
  return nativeModule('ffi.vision.widgets', [
    ('placeholder', placeholder),
    ('image', image(assets)),
    ('canvas', canvas),
    ('screen', screen),
    ('horizontal-slider', horizontalSlider),
    ('vertical-slider', verticalSlider),
    ('circular-slider', circularSlider),
    ('app', app),
    ('theme', theme),
    ('media-query', mediaQuery),
  ]);
}
