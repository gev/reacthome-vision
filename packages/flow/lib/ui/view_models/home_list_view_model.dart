import 'package:flow/common/view_model.dart';
import 'package:flow/core/home/home_api.dart';
import 'package:flow/core/home/home_event.dart';

class HomeListViewModel extends ViewModel<HomeEvent> {
  final HomeApi homeApi;

  HomeListViewModel({required super.eventSource, required this.homeApi});

  Iterable<String> get homes => homeApi.homes;

  @override
  bool shouldNotify(HomeEvent event) =>
      event is HomeAddedEvent || event is HomeRemovedEvent;
}
