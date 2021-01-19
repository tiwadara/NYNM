import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:resolution/src/resolutions/models/resolution.dart';
import 'package:resolution/src/tasks/models/task.dart';

class StorageService {
  static Future<void> init() async {
    await Hive.initFlutter();
    Hive.registerAdapter(TaskAdapter());
    Hive.registerAdapter(ResolutionAdapter());
  }

  Future openBox(String boxName) async {
    Box box = await Hive.openBox(boxName);
    return box;
  }

  Future close() {
    return Hive.close();
  }
}
