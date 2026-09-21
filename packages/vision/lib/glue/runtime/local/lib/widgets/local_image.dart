import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:glue/ir.dart';
import 'package:glue_flutter/glue_flutter.dart';

/// Image widget function
/// Creates Flutter Image on local file system
final localImage = IrNativeFunc(imageProviderImpl(fileImage));

ImageProvider fileImage(String src) => FileImage(File(src));
