// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'memory.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MemoryAdapter extends TypeAdapter<Memory> {
  @override
  final int typeId = 0;

  @override
  Memory read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Memory(
      url: fields[0] as String,
      byteList: fields[1] as Uint8List,
    )..creationTime = fields[2] as DateTime;
  }

  @override
  void write(BinaryWriter writer, Memory obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.url)
      ..writeByte(1)
      ..write(obj.byteList)
      ..writeByte(2)
      ..write(obj.creationTime);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MemoryAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
