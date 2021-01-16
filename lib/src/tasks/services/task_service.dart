import 'package:hive/hive.dart';
import 'package:resolution/src/commons/constants/storage_constants.dart';
import 'package:resolution/src/commons/services/notification_service.dart';
import 'package:resolution/src/commons/services/storage_service.dart';
import 'package:resolution/src/tasks/models/task.dart';

class TaskService {
  final StorageService storageService;
  final NotificationService notificationService;
  TaskService(this.storageService, this.notificationService);

  Future<Task> saveTask(Task task, int year) async {
    Box taskBox = await storageService.openBox(StorageConstants.TASK_BOX);
    List tasks = await taskBox.get(year, defaultValue: List<Task>.empty(growable: true));
    tasks.add(task);
    await taskBox.put(year, tasks);
    notificationService.periodicNotification(task);
    return task;
  }

  Future<dynamic> getAllTasks(int year) async {
    Box taskBox = await storageService.openBox(StorageConstants.TASK_BOX);
    var tasks =
        await taskBox.get(year, defaultValue: List<Task>.empty(growable: true));
    return tasks;
  }

  Future<Task> updateTask(Task task, int year, int index) async {
    Box taskBox = await storageService.openBox(StorageConstants.TASK_BOX);
    List tasks =
        await taskBox.get(year, defaultValue: List<Task>.empty(growable: true));
    await tasks.removeAt(index);
    tasks.insert(index, task);
    await taskBox.put(year, tasks);
    return task;
  }
}
