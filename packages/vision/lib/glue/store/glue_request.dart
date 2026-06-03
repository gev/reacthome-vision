import 'package:glue/ast.dart';
import 'package:glue/ir.dart';
import 'package:glue/serialize.dart';
import 'package:vision/pub_sub/request.dart';

class GlueRequest implements Request<IrDottedSymbol> {
  final Sink<String> _sink;

  const GlueRequest(this._sink);

  @override
  void subscribeOne(IrDottedSymbol key) {
    _request(_one(key));
  }

  @override
  void subscrybeMany(Iterable<IrDottedSymbol> keys) {
    _request(_many(keys));
  }

  ListAst _one(IrDottedSymbol key) {
    return ListAst([_get, SymbolAst("'$key")]);
  }

  ListAst _many(Iterable<IrDottedSymbol> keys) {
    return ListAst(keys.map(_one).toList());
  }

  void _request(ListAst ast) {
    _sink.add(serializeAst(ast));
  }

  static const _get = SymbolAst('get');
}
