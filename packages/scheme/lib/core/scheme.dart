import 'package:scheme/core/item.dart';
import 'package:scheme/core/link.dart';

class Scheme<Id> {
  const Scheme({
    required this.id,
    this.items = const [],
    this.links = const [],
  });

  final Id id;
  final Iterable<Item<Id>> items;
  final Iterable<Link<Id>> links;
}
