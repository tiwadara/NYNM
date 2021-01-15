import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:resolution/src/tasks/models/task.dart';

class NotificationService {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  AndroidInitializationSettings androidInitializationSettings;
  IOSInitializationSettings iosInitializationSettings;
  InitializationSettings initializationSettings;

  void initializing() async {
    androidInitializationSettings =
        AndroidInitializationSettings('ic_launcher');
    iosInitializationSettings = IOSInitializationSettings(
        onDidReceiveLocalNotification: onDidReceiveLocalNotification);
    initializationSettings = InitializationSettings(
        android: androidInitializationSettings, iOS: iosInitializationSettings);
    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: onSelectNotification);
  }

  Future onSelectNotification(String payLoad) {
    if (payLoad != null) {
      print(payLoad);
    }
    return null;
  }

  Future onDidReceiveLocalNotification(
      int id, String title, String body, String payload) async {
    print("notification receine" + payload.toString());
  }

  Future<void> periodicNotification(Task task) async {
    await flutterLocalNotificationsPlugin.periodicallyShow(
        0,
        task.name,
        task.description,
        task.getInterval(),
        NotificationDetails(
          android: AndroidNotificationDetails("0", task.name, task.description),
        ),
        androidAllowWhileIdle: true);
  }
}
