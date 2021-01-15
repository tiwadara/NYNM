import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:resolution/src/commons/services/base_storage_service.dart';
import 'package:resolution/src/resolutions/models/resolution.dart';
import 'package:resolution/src/tasks/models/task.dart';

class StorageService implements BaseStorageService {
  static Future<void> init() async {
    await Hive.initFlutter();
    Hive.registerAdapter(TaskAdapter());
    Hive.registerAdapter(ResolutionAdapter());
  }

  Future openBox(String boxName) async {
    Box box = await Hive.openBox(boxName);
    return box;
  }

  Future add(Box box, dynamic key, dynamic value) async {
    box.put(key, value);
    return box;
  }

  Future close() {
    return Hive.close();
  }

  @override
  Future<void> delete(HiveObject objectToDelete) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<List<HiveObject>> getAll() {
    // TODO: implement getAll
    throw UnimplementedError();
  }

  @override
  Future<void> save(Object newObject) {
    // TODO: implement save
    throw UnimplementedError();
  }
}
