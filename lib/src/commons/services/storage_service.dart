import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:resolution/src/commons/constants/storage_constants.dart';
import 'package:resolution/src/resolutions/models/resolution.dart';
import 'package:resolution/src/tasks/models/task.dart';

class StorageService {
  static Future<void> init() async {
    await Hive.initFlutter();
    Hive.registerAdapter(TaskAdapter());
    Hive.registerAdapter(ResolutionAdapter());
  }

  Future openBox(String boxName) async {
    Box box = await Hive.openBox<Resolution>(boxName);
    return box;
  }

  Future close() {
    return Hive.close();
  }

  Future<List<Task>> removeResolution(Task resolution) async {
    List<Task> resolutions = List<Task>.empty();
    final resolutionBox = await Hive.openBox(StorageConstants.USER_TASKS);
    resolutionBox.delete(resolution);
    resolutions.addAll(resolutionBox.values.map((e) => e));
    return resolutions;
  }

  Future<void> clearAllResolutions() async {
    final resolutionBox = await Hive.openBox(StorageConstants.USER_TASKS);
    await resolutionBox.clear();
  }

  Future<Task> saveResolution(Task resolution) async {
    final resolutionBox = await Hive.openBox(StorageConstants.USER_TASKS);
    await resolutionBox.add(resolution);
    return resolutionBox.values.singleWhere((element) => element == resolution);
  }

  Future<Task> updateResolution(Task resolution, int index) async {
    final resolutionBox = await Hive.openBox(StorageConstants.USER_TASKS);
    await resolutionBox.putAt(index, resolution);
    return resolutionBox.values.elementAt(index);
  }

  Future<Task> getResolution(Task resolution) async {
    final resolutionBox = await Hive.openBox(StorageConstants.USER_TASKS);
    return resolutionBox.values.singleWhere((element) => element == resolution);
  }

  Future<List<Task>> getAllResolutions() async {
    List<Task> resolutions = List<Task>();
    final resolutionBox = await Hive.openBox(StorageConstants.USER_TASKS);
    resolutions.addAll(resolutionBox.values.map((e) => e));
    return resolutions;
  }
}
