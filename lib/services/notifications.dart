import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

/*
		Show notification instantly
 */
Future showNotification(
  FlutterLocalNotificationsPlugin notification, {
  @required String title,
  @required String body,
  int id = 1,
}) async {
  var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'safair.aqi.timed', 'Safair-AQI', 'Air Quality Index',
      importance: Importance.High);
  var iOSPlatformChannelSpecifics = IOSNotificationDetails();
  var platformChannelSpecifics = NotificationDetails(
      androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);

  await notification.show(1, title, body, platformChannelSpecifics);
}

/*
		Show notification at a fixed time.
 */
Future showFixedTimeNotification(
  FlutterLocalNotificationsPlugin notification, {
  @required Time time,
  @required String title,
  @required String body,
  int id = 1,
}) async {
  var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'safair.aqi.timed', 'Safair-AQI', 'Air Quality Index');
  var iOSPlatformChannelSpecifics = IOSNotificationDetails();
  var platformChannelSpecifics = NotificationDetails(
      androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);

  await notification.showDailyAtTime(
      1, title, body, time, platformChannelSpecifics);
}

/*
		Periodically show notification with a specified interval
 */
Future showPeriodicNotification(
  FlutterLocalNotificationsPlugin notification, {
  @required String title,
  @required String body,
  @required dynamic repeatInterval,
  int id = 1,
}) async {
  var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'safair.aqi.periodic', 'Safair-AQI', 'Air Quality Index');
  var iOSPlatformChannelSpecifics = IOSNotificationDetails();
  var platformChannelSpecifics = NotificationDetails(
      androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);

  await notification.periodicallyShow(
      id, title, body, repeatInterval, platformChannelSpecifics);
}

/*
		Silent Notification
 */
NotificationDetails get _nosound {
  final androidChannelSpecifics = AndroidNotificationDetails(
    'Your channel id',
    'Your channel name',
    'Your channel description',
    importance: Importance.Default,
    playSound: false,
  );
  final iOSChannelSpecifics = IOSNotificationDetails(presentSound: false);
  return NotificationDetails(androidChannelSpecifics, iOSChannelSpecifics);
}

Future showSilentNotification(
  FlutterLocalNotificationsPlugin notifications, {
  @required String title,
  @required String body,
  int id = 0,
}) =>
    _showNotification(notifications,
        title: title, body: body, id: id, type: _nosound);

/*
		on-going Notification
 */
NotificationDetails get _ongoing {
  final androidChannelSpecifics = AndroidNotificationDetails(
    'Your channel id',
    'Your channel name',
    'Your channel description',
    importance: Importance.Default,
    ongoing: true,
    autoCancel: true,
  );
  final iOSChannelSpecifics = IOSNotificationDetails();
  return NotificationDetails(androidChannelSpecifics, iOSChannelSpecifics);
}

Future _showNotification(
  FlutterLocalNotificationsPlugin notifications, {
  @required String title,
  @required String body,
  @required NotificationDetails type,
  int id = 0,
}) =>
    notifications.show(id, title, body, type);

Future showOngoingNotification(
  FlutterLocalNotificationsPlugin notifications, {
  @required String title,
  @required String body,
  int id = 0,
}) =>
    _showNotification(notifications,
        title: title, body: body, id: id, type: _ongoing);
