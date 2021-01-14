import 'package:hive/hive.dart';
import 'package:kiwi/kiwi.dart';
import 'package:resolution/src/commons/services/notification_service.dart';
import 'package:resolution/src/commons/services/storage_service.dart';
import 'package:resolution/src/resolutions/services/resolution_service.dart';
import 'package:resolution/src/tasks/services/task_service.dart';

part 'di_container.g.dart';

abstract class Injector {
  @Register.singleton(TaskService)
  @Register.singleton(ResolutionService)
  @Register.singleton(StorageService)
  @Register.singleton(NotificationService)
  void configure();
}

void setupDI() {
  var injector = _$Injector();
  injector.configure();
}
