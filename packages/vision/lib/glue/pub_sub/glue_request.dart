import 'package:glue/ast.dart';
import 'package:glue/serialize.dart';

import 'package:vision/pub_sub/request.dart';

class GlueRequest implements Request<String, int> {
  final Sink<String> _sink;

  GlueRequest(this._sink);

  static const _get = SymbolAst('get');

  @override
  void subscribeOne(Predicate<String, int> pred) {
    _request(_one(pred));
  }

  @override
  void subscribeMany(Specification<String, int> spec) {
    if (spec.isNotEmpty) _request(_many(spec));
  }

  ListAst _one(Predicate<String, int> pred) {
    return ListAst([_get, SymbolAst(pred.key), IntegerAst(pred.version ?? 0)]);
  }

  ListAst _many(Specification<String, int> spec) {
    return ListAst(spec.map(_one).toList());
  }

  void _request(ListAst ast) {
    _sink.add(serializeAst(ast));
  }
}
