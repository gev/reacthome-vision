import 'package:glue/ir.dart';
import 'package:vision/store/lookup.dart';
import 'package:vision/store/put.dart';
import 'package:vision/store/revision.dart';
import 'package:vision/store/version.dart';

typedef GlueReactiveLookup = ReactiveLookup<String, Ir>;
typedef GluePut = Put<String, Revision<Ir, int>>;
typedef GlueVersion = Version<String, int>;
