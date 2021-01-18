import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:resolution/src/commons/constants/storage_constants.dart';

part 'task.g.dart';

@JsonSerializable()
@HiveType(typeId: StorageConstants.TYPE_TASK)
class Task extends HiveObject {
  @HiveField(0)
  bool done;
  @HiveField(1)
  String name;
  @HiveField(2)
  String description;
  @HiveField(3)
  String interval;

  Task({this.done, this.name, this.description, this.interval});

  factory Task.fromJson(Map<String, dynamic> json) => _$TaskFromJson(json);

  Map<String, dynamic> toJson() => _$TaskToJson(this);

  bool checkIfAnyIsNull() {
    List searchProperties = [name, description, interval];
    return searchProperties.contains(null) || searchProperties.contains("");
  }

  getInterval() {
    if (interval == "DAILY") {
      return RepeatInterval.daily;
    } else if (interval == "WEEKLY") {
      return RepeatInterval.weekly;
    } else if (interval == "MONTHLY") {
      return RepeatInterval.everyMinute;
    }
  }
}
