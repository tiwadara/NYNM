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
      year: fields[0] as int,
      motto: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Resolution obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.year)
      ..writeByte(1)
      ..write(obj.motto);
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
    year: json['year'] as int,
    motto: json['motto'] as String,
  );
}

Map<String, dynamic> _$ResolutionToJson(Resolution instance) =>
    <String, dynamic>{
      'year': instance.year,
      'motto': instance.motto,
    };
