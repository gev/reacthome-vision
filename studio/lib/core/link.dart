import 'package:studio/ui/stages/anchor_line.dart';

class Connector<Id> {
  Connector({required this.id, required this.direction});

  final Id id;
  final Direction direction;
}

class Link<Id> {
  Link({required this.id, required this.source, required this.sink});

  final Id id;
  final Connector<Id> source;
  final Connector<Id> sink;
}
