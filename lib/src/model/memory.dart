import 'dart:typed_data';

import 'package:hive/hive.dart';

part "memory.g.dart";

@HiveType(typeId: 0)
class Memory extends HiveObject {
  @HiveField(0)
  String url;

  @HiveField(1)
  Uint8List byteList;

  @HiveField(2)
  DateTime creationTime = DateTime.now();

  Memory({required this.url, required this.byteList});
}
