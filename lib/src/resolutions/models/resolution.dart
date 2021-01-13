import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:resolution/src/commons/constants/storage_constants.dart';

part 'resolution.g.dart';

@JsonSerializable()
@HiveType(typeId: StorageConstants.TYPE_RESOLUTION)
class Resolution {
  @HiveField(0)
  String status;
  @HiveField(1)
  String name;
  @HiveField(2)
  String description;
  @HiveField(3)
  String interval;
  @HiveField(4)
  int increment;

  Resolution(
      {this.status,
      this.name,
      this.description,
      this.interval,
      this.increment});

  factory Resolution.fromJson(Map<String, dynamic> json) =>
      _$ResolutionFromJson(json);

  Map<String, dynamic> toJson() => _$ResolutionToJson(this);

  bool checkIfAnyIsNull() {
    List searchProperties = [name, description];
    return searchProperties.contains(null) || searchProperties.contains("");
  }
}
