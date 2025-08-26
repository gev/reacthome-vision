import 'dart:ui';

enum ItemType { dummy }

class Item<Id> {
  const Item({required this.id, required this.position});

  final Id id;
  final Offset position;

  void moveTo(Offset position) => Item(id: id, position: position);
}
