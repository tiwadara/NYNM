import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:hive/hive.dart';
import 'package:mockito/mockito.dart';
import 'package:resolution/src/commons/services/notification_service.dart';
import 'package:resolution/src/commons/services/storage_service.dart';
import 'package:resolution/src/resolutions/services/resolution_service.dart';
import 'package:resolution/src/tasks/services/task_service.dart';

class MockStorageService extends Mock implements StorageService {}

class MockResolutionService extends Mock implements ResolutionService {}

class MockTaskService extends Mock implements TaskService {}

class MockNotificationService extends Mock implements NotificationService {}

class MockHiveInterface extends Mock implements HiveInterface {}

class MockHiveBox extends Mock implements Box {}

class MockFlutterLocalNotificationsPlugin extends Mock  implements FlutterLocalNotificationsPlugin {}