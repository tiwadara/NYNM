import 'package:hive/hive.dart';

abstract class BaseStorageService<T extends HiveObject> {
  Future<void> save(T newObject);

  Future<void> delete(T objectToDelete);

  Future<List<T>> getAll();
}
