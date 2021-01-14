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
      year: fields[0] as String,
      motto: fields[1] as String,
      tasks: (fields[2] as List)?.cast<Task>(),
    );
  }

  @override
  void write(BinaryWriter writer, Resolution obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.year)
      ..writeByte(1)
      ..write(obj.motto)
      ..writeByte(2)
      ..write(obj.tasks);
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
    year: json['year'] as String,
    motto: json['motto'] as String,
    tasks: (json['tasks'] as List)
        ?.map(
            (e) => e == null ? null : Task.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$ResolutionToJson(Resolution instance) =>
    <String, dynamic>{
      'year': instance.year,
      'motto': instance.motto,
      'tasks': instance.tasks,
    };
