import 'package:glue/ast.dart';
import 'package:glue/serialize.dart';
import 'package:vision/pub_sub/request.dart';

class GlueRequest implements Request<String> {
  final Sink<String> _sink;

  const GlueRequest(this._sink);

  @override
  void subscribeOne(String key) {
    _request(_one(key));
  }

  @override
  void subscrybeMany(Iterable<String> keys) {
    _request(_many(keys));
  }

  ListAst _one(String key) {
    return ListAst([_get, SymbolAst("'$key")]);
  }

  ListAst _many(Iterable<String> keys) {
    return ListAst(keys.map(_one).toList());
  }

  void _request(ListAst ast) {
    _sink.add(serializeAst(ast));
  }

  static const _get = SymbolAst('get');
}
