import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:resolution/src/commons/constants/storage_constants.dart';
import 'package:resolution/src/tasks/models/task.dart';

part 'resolution.g.dart';

@JsonSerializable()
@HiveType(typeId: StorageConstants.TYPE_RESOLUTION)
class Resolution {
  @HiveField(0)
  String year;
  @HiveField(1)
  String motto;
  @HiveField(2)
  List<Task> tasks;

  Resolution({this.year, this.motto, List<Task> tasks}) : tasks = [];

  factory Resolution.fromJson(Map<String, dynamic> json) =>
      _$ResolutionFromJson(json);

  Map<String, dynamic> toJson() => _$ResolutionToJson(this);

  bool checkIfAnyIsNull() {
    List searchProperties = [year, motto];
    return searchProperties.contains(null) || searchProperties.contains("");
  }
}
