// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'resolution.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ResolutionAdapter extends TypeAdapter<Resolution> {
  @override
  final int typeId = 0;

  @override
  Resolution read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Resolution(
      status: fields[0] as String,
      name: fields[1] as String,
      description: fields[2] as String,
      interval: fields[3] as String,
      increment: fields[4] as int,
    );
  }

  @override
  void write(BinaryWriter writer, Resolution obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.status)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.description)
      ..writeByte(3)
      ..write(obj.interval)
      ..writeByte(4)
      ..write(obj.increment);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ResolutionAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Resolution _$ResolutionFromJson(Map<String, dynamic> json) {
  return Resolution(
    status: json['status'] as String,
    name: json['name'] as String,
    description: json['description'] as String,
    interval: json['interval'] as String,
    increment: json['increment'] as int,
  );
}

Map<String, dynamic> _$ResolutionToJson(Resolution instance) =>
    <String, dynamic>{
      'status': instance.status,
      'name': instance.name,
      'description': instance.description,
      'interval': instance.interval,
      'increment': instance.increment,
    };
