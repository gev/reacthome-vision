import 'package:glue/ast.dart';
import 'package:glue/serialize.dart';
import 'package:vision/pub_sub/request.dart';

class GlueRequest implements Request<String> {
  final SymbolAst _store;
  final Sink<String> _sink;

  GlueRequest(String prefix, String name, this._sink)
    : _store = SymbolAst("'$prefix.$name");

  @override
  void one(String key) {
    _request(_one(key));
  }

  @override
  void many(Iterable<String> keys) {
    _request(_many(keys));
  }

  ListAst _one(String key) {
    return ListAst([_get, _store, StringAst(key)]);
  }

  ListAst _many(Iterable<String> keys) {
    return ListAst([_get, _store, ...keys.map(StringAst.new)]);
  }

  void _request(ListAst ast) {
    _sink.add(serializeAst(ast));
  }

  static const _get = SymbolAst('get');
}
