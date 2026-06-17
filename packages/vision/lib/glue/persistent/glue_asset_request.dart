import 'package:glue/ast.dart';
import 'package:glue/serialize.dart';
import 'package:vision/persistent/asset_request.dart';

class GlueAssetRequest implements AssetRequest {
  final Sink<String> _sink;

  GlueAssetRequest(this._sink);

  static const _get = SymbolAst('get-asset');

  @override
  void get(String name) {
    _sink.add(serializeAst(ListAst([_get, SymbolAst(name)])));
  }
}
