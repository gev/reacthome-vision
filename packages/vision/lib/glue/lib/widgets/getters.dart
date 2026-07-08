import 'package:glue/eval.dart';
import 'package:glue/ir.dart';

Map<String, Eval<Ir>> makeGetters(Map<String, dynamic> props) =>
    props.map((key, value) => MapEntry(key, Eval.pure(toIr(value))));
