import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:resolution/src/tasks/models/task.dart';

class NotificationService {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  AndroidInitializationSettings androidInitializationSettings;
  IOSInitializationSettings iosInitializationSettings;
  InitializationSettings initializationSettings;

  void initializing() async {
    androidInitializationSettings = AndroidInitializationSettings('@mipmap/ic_launcher');
    iosInitializationSettings = IOSInitializationSettings(onDidReceiveLocalNotification: onDidReceiveLocalNotification);
    initializationSettings = InitializationSettings(android: androidInitializationSettings, iOS: iosInitializationSettings);
    await flutterLocalNotificationsPlugin.initialize(initializationSettings, onSelectNotification: onSelectNotification);
  }

  Future onSelectNotification(String payLoad) {
    if (payLoad != null) {
      print(payLoad);
    }
    return null;
  }

  Future onDidReceiveLocalNotification(int id, String title, String body, String payload) async {}

  Future<void> periodicNotification(Task task, int id) async {
  await flutterLocalNotificationsPlugin.periodicallyShow(
        id,
        task.name,
        task.description,
        task.getInterval(),
        NotificationDetails(android: AndroidNotificationDetails("0", task.name, task.description),
        ),
        androidAllowWhileIdle: true);
  confirmNotificationWasAdded(id);
  }

  confirmNotificationWasAdded(int id) async {
    print(id .toString());
   var pendingNotifications = await  flutterLocalNotificationsPlugin.pendingNotificationRequests();
   print(pendingNotifications[id].id .toString());
  }
}
