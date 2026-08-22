import 'dart:isolate';
import 'package:vision/store/revision.dart';

sealed class DbCommand {}

class LookupCmd extends DbCommand {
  final String key;
  final SendPort replyTo;
  LookupCmd(this.key, this.replyTo);
}

class StoreCmd extends DbCommand {
  final String key;
  final Revision<String, int> value;
  final SendPort replyTo;
  StoreCmd(this.key, this.value, this.replyTo);
}

class DisposeCmd extends DbCommand {}
