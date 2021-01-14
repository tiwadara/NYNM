import 'package:resolution/src/commons/services/storage_service.dart';
import 'package:resolution/src/tasks/models/task.dart';

class TaskService {
  final StorageService storageService;
  TaskService(this.storageService);

  Future<Task> saveResolution(Task resolution) async {
    return storageService.saveResolution(resolution);
  }

  Future<Task> getResolution(Task resolution) async {
    return storageService.getResolution(resolution);
  }

  Future<List<Task>> getAllResolution() async {
    return await storageService.getAllResolutions();
  }

  Future<Task> updateResolution(Task resolution, int index) async {
    return storageService.updateResolution(resolution, index);
  }
}
