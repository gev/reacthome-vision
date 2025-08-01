import 'package:common/emitter.dart';
import 'package:common/entity.dart';
import 'package:common/entity_event.dart';
import 'package:common/repository/box_repository.dart';

class CachedBoxRepository<E extends Entity<String>>
    implements BoxRepository<E> {
  final Emitter<EntityEvent> eventSink;
  final BoxRepository<E> box;

  CachedBoxRepository({required this.eventSink, required this.box}) {
    eventSink.emit(EntityRegisteredEvent(box.value.id));
  }

  @override
  E get value => box.value;

  @override
  void put(E entity) {
    box.put(entity);
    eventSink.emit(EntityRegisteredEvent(entity.id));
  }
}
