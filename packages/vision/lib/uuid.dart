import 'package:uuid/uuid.dart';

final uuidGenerator = Uuid();
String uuid() => uuidGenerator.v4();
