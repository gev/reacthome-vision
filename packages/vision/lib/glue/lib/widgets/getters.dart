import 'package:glue/eval.dart';
import 'package:glue/ir.dart';

Map<String, Eval<Ir>> makeGetters(Map<String, dynamic> props) =>
    props.map((key, value) => MapEntry(key, Eval.pure(toIr(value))));

Ir toIr(dynamic value) => switch (value) {
  null => IrVoid(),
  bool value => IrBool(value),
  int value => IrInteger(value),
  double value => IrFloat(value),
  Iterable values => IrList(values.map(toIr).toList()),
  IrNativeValue value => value,
  _ => IrNativeValue(Value(value)),
};
