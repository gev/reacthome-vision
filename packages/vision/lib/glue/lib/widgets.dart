import 'package:glue/module.dart';
import 'package:vision/glue/lib/widgets/app.dart';
import 'package:vision/glue/lib/widgets/canvas.dart';
import 'package:vision/glue/lib/widgets/image.dart';
import 'package:vision/glue/lib/widgets/placeholder.dart';
import 'package:vision/glue/lib/widgets/screen.dart';
import 'package:vision/persistent/assets.dart';

ModuleInfo widgetsModule(Assets assets) {
  return nativeModule('ffi.vision.widgets', [
    ('app', app),
    ('placeholder', placeholder),
    ('screen', screen),
    ('image', image(assets)),
    ('canvas', canvas),
  ]);
}
