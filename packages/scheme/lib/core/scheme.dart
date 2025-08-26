import 'dart:ui';

import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:scheme/core/item.dart';
import 'package:scheme/core/link.dart';

class Scheme<Id> {
  Scheme({
    required this.id,
    Iterable<Item<Id>> items = const [],
    Iterable<Link<Id>> links = const [],
  }) {
    _items = IMap.fromIterables(items.map((it) => it.id), items);
    _links = IMap.fromIterables(links.map((it) => it.id), links);
  }

  Scheme._(this.id, this._items, this._links);

  final Id id;

  late final IMap<Id, Item<Id>> _items;
  late final IMap<Id, Link<Id>> _links;

  Iterable<Item<Id>> get items => _items.values;
  Iterable<Link<Id>> get links => _links.values;

  Item<Id> item(Id id) => _items.get(id)!;
  Link<Id> link(Id id) => _links.get(id)!;

  Scheme moveItemTo(Id id, Offset position) {
    final item = _items.get(id);
    if (item != null) {
      return Scheme._(id, _items.add(id, item.moveTo(position)), _links);
    }
    return this;
  }
}
