import 'package:glue/ir.dart';
import 'package:glue/module.dart';
import 'package:vision/glue/lib/widgets/activity.dart';
import 'package:vision/glue/lib/widgets/app.dart';
import 'package:vision/glue/lib/widgets/canvas.dart';
import 'package:vision/glue/lib/widgets/closures.dart';
import 'package:vision/glue/lib/widgets/locale.dart';
import 'package:vision/glue/lib/widgets/media_query.dart';
import 'package:vision/glue/lib/widgets/placeholder.dart';
import 'package:vision/glue/lib/widgets/scaffold.dart';
import 'package:vision/glue/lib/widgets/slider/circular_slider.dart';
import 'package:vision/glue/lib/widgets/slider/horizontal_slider.dart';
import 'package:vision/glue/lib/widgets/slider/vertical_slider.dart';
import 'package:vision/glue/lib/widgets/theme.dart';

ModuleInfo widgetsModule({required Ir image}) {
  return nativeModule('ffi.vision.widgets', [
    ('activity', activity),
    ('placeholder', placeholder),
    ('image', image),
    ('canvas', canvas),
    ('scaffold', scaffold),
    ('horizontal-slider', horizontalSlider),
    ('vertical-slider', verticalSlider),
    ('circular-slider', circularSlider),
    ('double-curtain', doubleCurtain),
    ('double-gate', doubleGate),
    ('left-curtain', leftCurtain),
    ('left-gate', leftGate),
    ('right-curtain', rightCurtain),
    ('right-gate', rightGate),
    ('shutter', shutter),
    ('app', app),
    ('locale', locale),
    ('media-query', mediaQuery),
    ('theme', theme),
  ]);
}
